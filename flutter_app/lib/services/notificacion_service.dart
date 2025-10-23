import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/notificacion.dart';

class NotificacionService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<Notificacion>> getNotificaciones(int usuarioId) async {
    final response = await http.get(Uri.parse('$baseUrl/notificaciones?usuarioId=$usuarioId'));
    final List data = jsonDecode(response.body);
    return data.map((e) => Notificacion.fromJson(e)).toList();
  }

  Future<bool> marcarLeida(int notificacionId) async {
    final response = await http.put(
      Uri.parse('$baseUrl/notificaciones/$notificacionId/leida'),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}

