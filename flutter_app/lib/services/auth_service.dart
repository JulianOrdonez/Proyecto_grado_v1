import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Cambia localhost por 10.0.2.2 para emulador Android
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Error de autenticación');
    }
  }

  Future<Map<String, dynamic>> register(String nombre, String email, String password, String rol) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nombre': nombre, 'email': email, 'password': password, 'rol': rol}),
    );
    return jsonDecode(response.body);
  }

  // Nuevo: logout
  Future<void> logout() async {
    try {
      await http.post(Uri.parse('$baseUrl/logout'));
    } catch (_) {
      // Ignorar errores de red en logout para no bloquear la salida.
    }
  }
}
