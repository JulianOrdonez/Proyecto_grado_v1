import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/reporte.dart';
import '../services/reporte_service.dart';

class TodosReportesScreen extends StatefulWidget {
  const TodosReportesScreen({super.key});

  @override
  State<TodosReportesScreen> createState() => _TodosReportesScreenState();
}

class _TodosReportesScreenState extends State<TodosReportesScreen> {
  final ReporteService _reporteService = ReporteService();
  List<Reporte> _reportes = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchReportes();
  }

  Future<void> _fetchReportes() async {
    setState(() { _loading = true; _error = null; });
    try {
      _reportes = await _reporteService.getReportes();
    } catch (e) {
      _error = 'Error al cargar reportes';
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _cambiarEstado(int reporteId, String nuevoEstado) async {
    final ok = await _reporteService.cambiarEstado(reporteId, nuevoEstado);
    if (ok) await _fetchReportes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.clipboardList, size: 22),
            SizedBox(width: 8),
            Text('Todos los reportes'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : ListView.builder(
                    itemCount: _reportes.length,
                    itemBuilder: (context, index) {
                      final reporte = _reportes[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FaIcon(FontAwesomeIcons.fileAlt, size: 32),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Aula: ${reporte.salon}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    Text('Edificio: ${reporte.edificio}'),
                                    Text('Dependencia: ${reporte.dependencia}'),
                                    Text('Tipo de aula: ${reporte.tipoAula}'),
                                    Text('Sillas: ${reporte.sillas}'),
                                    const SizedBox(height: 4),
                                    Text('Descripción: ${reporte.descripcion}'),
                                    const SizedBox(height: 4),
                                    Text('Estado: ${reporte.estado}'),
                                    Text('Fecha: ${reporte.fecha.toLocal()}'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
