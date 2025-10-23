import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/comentario.dart';

class ComentarioService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<Comentario>> getHistorial(int reporteId) async {
    final response = await http.get(Uri.parse('$baseUrl/reportes/$reporteId/historial'));
    final List data = jsonDecode(response.body);
    return data.map((e) => Comentario.fromJson(e)).toList();
  }

  Future<bool> agregarComentario(int reporteId, int usuarioId, String comentario, {String? archivoUrl}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reportes/$reporteId/comentarios'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario_id': usuarioId,
        'comentario': comentario,
        'archivo_url': archivoUrl,
      }),
    );
    return response.statusCode == 201;
  }
}

