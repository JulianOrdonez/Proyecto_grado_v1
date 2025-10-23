import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _error;
  bool _loading = false;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _loading = true; _error = null; });
      final auth = AuthService();
      try {
        print('Login con email: $_email, password: $_password');
        final result = await auth.login(_email, _password);
        print('Resultado login: $result');
        final rol = (result['rol'] ?? '').toString().trim().toLowerCase();
        print('Rol recibido: $rol');
        // Guardar usuarioId y rol en SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('usuarioId', result['id']);
        await prefs.setString('rol', rol);
        await prefs.setString('nombre', result['nombre'] ?? '');
        await prefs.setString('email', result['email'] ?? '');
        setState(() { _error = null; }); // Limpiar error antes de navegar
        if (rol == 'admin') {
          Navigator.pushReplacementNamed(context, '/home_admin');
          return;
        } else if (rol == 'docente') {
          Navigator.pushReplacementNamed(context, '/home_docente');
          return;
        } else if (rol == 'tecnico') {
          Navigator.pushReplacementNamed(context, '/home_tecnico');
          return;
        } else {
          setState(() { _error = 'Rol no reconocido'; });
        }
      } catch (e) {
        setState(() { _error = 'Usuario o contraseña incorrectos'; });
      } finally {
        setState(() { _loading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
                validator: (value) => value == null || value.isEmpty ? 'Ingrese email' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
                onChanged: (value) => _password = value,
                validator: (value) => value == null || value.isEmpty ? 'Ingrese contraseña' : null,
              ),
              if (_error != null) ...[
                SizedBox(height: 10),
                Text(_error!, style: TextStyle(color: Colors.red)),
              ],
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text('Ingresar'),
                    ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
