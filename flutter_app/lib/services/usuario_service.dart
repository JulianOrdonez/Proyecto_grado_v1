import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<Usuario>> getUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));
    final List data = jsonDecode(response.body);
    return data.map((e) => Usuario.fromJson(e)).toList();
  }

  Future<bool> cambiarRol(int usuarioId, String nuevoRol) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$usuarioId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rol': nuevoRol}),
    );
    print('cambiarRol status: [33m${response.statusCode}[0m');
    print('cambiarRol body: [36m${response.body}[0m');
    return response.statusCode == 200 || response.statusCode == 204;
  }

  Future<bool> eliminarUsuario(int usuarioId) async {
    final response = await http.delete(Uri.parse('$baseUrl/usuarios/$usuarioId'));
    print('eliminarUsuario status: [33m${response.statusCode}[0m');
    print('eliminarUsuario body: [36m${response.body}[0m');
    return response.statusCode == 200 || response.statusCode == 204;
  }

  Future<Map<String, dynamic>> register(String nombre, String email, String password, String rol) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombre,
        'email': email,
        'password': password,
        'rol': rol,
      }),
    );
    return jsonDecode(response.body);
  }
}
