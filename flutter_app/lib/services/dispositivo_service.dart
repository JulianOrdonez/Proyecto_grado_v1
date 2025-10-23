import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dispositivo.dart';

class DispositivoService {
  static const String baseUrl = 'http://10.0.2.2:3001/api';

  Future<List<Dispositivo>> getDispositivos() async {
    final response = await http.get(Uri.parse('$baseUrl/dispositivos'));
    final List data = jsonDecode(response.body);
    return data.map((e) => Dispositivo.fromJson(e)).toList();
  }
}

