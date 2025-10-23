import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/solicitud_material.dart';

class MaterialService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<SolicitudMaterial>> getSolicitudes(int usuarioId) async {
    final response = await http.get(Uri.parse('$baseUrl/solicitudes-materiales?usuarioId=$usuarioId'));
    final List data = jsonDecode(response.body);
    return data.map((e) => SolicitudMaterial.fromJson(e)).toList();
  }

  Future<bool> crearSolicitud(int usuarioId, String tipoMaterial, int cantidad, String descripcion) async {
    final response = await http.post(
      Uri.parse('$baseUrl/solicitudes-materiales'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario_id': usuarioId,
        'tipo_material': tipoMaterial,
        'cantidad': cantidad,
        'descripcion': descripcion,
      }),
    );
    return response.statusCode == 201;
  }
}

