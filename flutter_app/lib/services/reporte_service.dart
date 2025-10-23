import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reporte.dart';

class ReporteService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<Reporte>> getReportes({
    int? usuarioId,
    String? rol,
    String? estado,
    String? aula,
    String? tipoAula,
    String? busqueda,
  }) async {
    final queryParams = <String, String>{};
    if (usuarioId != null) queryParams['usuarioId'] = usuarioId.toString();
    if (rol != null) queryParams['rol'] = rol;
    if (estado != null && estado.isNotEmpty) queryParams['estado'] = estado;
    if (aula != null && aula.isNotEmpty) queryParams['aula'] = aula;
    if (tipoAula != null && tipoAula.isNotEmpty) queryParams['tipoAula'] = tipoAula;
    if (busqueda != null && busqueda.isNotEmpty) queryParams['busqueda'] = busqueda;
    final uri = Uri.parse('$baseUrl/reportes').replace(queryParameters: queryParams);
    final response = await http.get(uri);
    final List data = jsonDecode(response.body);
    return data.map((e) => Reporte.fromJson(e)).toList();
  }

  Future<bool> crearReporte(Reporte reporte) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reportes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario_id': reporte.usuarioId,
        'salon': reporte.salon,
        'descripcion': reporte.descripcion,
        'edificio': reporte.edificio,
        'dependencia': reporte.dependencia,
        'tipo_aula': reporte.tipoAula,
        'sillas': reporte.sillas,
      }),
    );
    return response.statusCode == 201;
  }

  Future<bool> cambiarEstado(int reporteId, String estado) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reportes/$reporteId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'estado': estado}),
    );
    return response.statusCode == 200;
  }
}
