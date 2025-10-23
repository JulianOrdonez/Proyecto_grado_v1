import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _email = '';
  String _password = '';
  String _role = 'docente';
  String? _error;
  bool _loading = false;
  String? _success;

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _loading = true; _error = null; _success = null; });
      final auth = AuthService();
      try {
        final result = await auth.register(_nombre, _email, _password, _role);
        if (result['message'] == 'Usuario registrado correctamente') {
          setState(() { _success = 'Registro exitoso. Ahora puede iniciar sesión.'; });
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else {
          setState(() { _error = result['message'] ?? 'Error en el registro'; });
        }
      } catch (e) {
        setState(() { _error = 'Error en el servidor'; });
      } finally {
        setState(() { _loading = false; });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de usuario')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => _nombre = value,
                validator: (value) => value == null || value.isEmpty ? 'Ingrese nombre' : null,
              ),
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
              DropdownButtonFormField<String>(
                value: _role,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'docente', child: Text('Docente')),
                  DropdownMenuItem(value: 'tecnico', child: Text('Técnico')),
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                ],
                onChanged: (value) => setState(() { _role = value!; }),
              ),
              if (_error != null) ...[
                SizedBox(height: 10),
                Text(_error!, style: TextStyle(color: Colors.red)),
              ],
              if (_success != null) ...[
                SizedBox(height: 10),
                Text(_success!, style: TextStyle(color: Colors.green)),
              ],
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _register,
                      child: Text('Registrar'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
