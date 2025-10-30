import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/usuario.dart';
import '../services/usuario_service.dart';
import '../services/auth_service.dart';

class UsuariosScreen extends StatefulWidget {
  const UsuariosScreen({super.key});

  @override
  State<UsuariosScreen> createState() => _UsuariosScreenState();
}

class _UsuariosScreenState extends State<UsuariosScreen> {
  final UsuarioService _usuarioService = UsuarioService();
  List<Usuario> _usuarios = [];
  bool _loading = true;
  String? _error;

  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _nuevoRol = 'docente';

  @override
  void initState() {
    super.initState();
    _fetchUsuarios();
  }

  Future<void> _logout() async {
    await AuthService().logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _fetchUsuarios() async {
    setState(() { _loading = true; _error = null; });
    try {
      _usuarios = await _usuarioService.getUsuarios();
    } catch (e) {
      _error = 'Error al cargar usuarios';
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _cambiarRol(int usuarioId, String nuevoRol) async {
    final ok = await _usuarioService.cambiarRol(usuarioId, nuevoRol);
    if (ok) {
      await _fetchUsuarios();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rol actualizado correctamente')),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar rol')),
      );
    }
  }

  Future<void> _eliminarUsuario(int usuarioId) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Seguro que deseas eliminar este usuario? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );
    if (confirmar != true) return;

    final ok = await _usuarioService.eliminarUsuario(usuarioId);
    if (ok) {
      await _fetchUsuarios();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario eliminado correctamente')),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar usuario')),
      );
    }
  }

  Future<void> _crearUsuario() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; });
    try {
      final response = await _usuarioService.register(
        _nombreController.text,
        _emailController.text,
        _passwordController.text,
        _nuevoRol,
      );
      if (response['message'] == 'Usuario registrado correctamente') {
        _nombreController.clear();
        _emailController.clear();
        _passwordController.clear();
        await _fetchUsuarios();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario creado correctamente')),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Error al crear usuario')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear usuario')),
      );
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.usersCog, size: 22),
            SizedBox(width: 8),
            Text('Gestión de usuarios y roles'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const FaIcon(FontAwesomeIcons.powerOff),
            onPressed: _logout,
          )
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: const [
                                FaIcon(FontAwesomeIcons.userPlus, size: 18),
                                SizedBox(width: 6),
                                Text('Añadir usuario', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            TextFormField(
                              controller: _nombreController,
                              decoration: const InputDecoration(labelText: 'Nombre'),
                              validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(labelText: 'Email'),
                              validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              decoration: const InputDecoration(labelText: 'Contraseña'),
                              obscureText: true,
                              validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                            ),
                            DropdownButtonFormField<String>(
                              value: _nuevoRol,
                              items: const [
                                DropdownMenuItem(value: 'admin', child: Text('Admin')),
                                DropdownMenuItem(value: 'docente', child: Text('Docente')),
                                DropdownMenuItem(value: 'tecnico', child: Text('Técnico')),
                              ],
                              onChanged: (value) {
                                if (value != null) setState(() { _nuevoRol = value; });
                              },
                              decoration: const InputDecoration(labelText: 'Rol'),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: _crearUsuario,
                              icon: const FaIcon(FontAwesomeIcons.userPlus),
                              label: const Text('Crear usuario'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = _usuarios[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: ListTile(
                              leading: const FaIcon(FontAwesomeIcons.user),
                              title: Text(usuario.nombre),
                              subtitle: Text(usuario.email),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Botón eliminar
                                  IconButton(
                                    icon: const FaIcon(FontAwesomeIcons.trashAlt, size: 18),
                                    onPressed: () => _eliminarUsuario(usuario.id),
                                  ),
                                  // Dropdown para cambiar rol
                                  DropdownButton<String>(
                                    value: usuario.rol,
                                    icon: const FaIcon(FontAwesomeIcons.angleDown, size: 18),
                                    underline: Container(),
                                    items: const [
                                      DropdownMenuItem(value: 'admin', child: Text('Admin')),
                                      DropdownMenuItem(value: 'docente', child: Text('Docente')),
                                      DropdownMenuItem(value: 'tecnico', child: Text('Técnico')),
                                    ],
                                    onChanged: (nuevoRol) {
                                      if (nuevoRol != null && nuevoRol != usuario.rol) {
                                        _cambiarRol(usuario.id, nuevoRol);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
