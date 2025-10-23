import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/reporte.dart';
import '../services/reporte_service.dart';
import 'crear_reporte_screen.dart';
import 'detalle_reporte_screen.dart';
import 'notificaciones_screen.dart';

class MisReportesScreen extends StatefulWidget {
  const MisReportesScreen({super.key});

  @override
  State<MisReportesScreen> createState() => _MisReportesScreenState();
}

class _MisReportesScreenState extends State<MisReportesScreen> {
  final ReporteService _reporteService = ReporteService();
  List<Reporte> _reportes = [];
  bool _loading = false;
  String? _error;
  int? usuarioId;

  String _filtroEstado = '';
  String _filtroAula = '';
  String _filtroTipoAula = '';
  final _busquedaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUsuarioId();
  }

  Future<void> _loadUsuarioId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      usuarioId = prefs.getInt('usuarioId');
    });
    if (usuarioId != null) {
      await _fetchReportes();
    }
  }

  Future<void> _fetchReportes() async {
    if (usuarioId == null) return;
    setState(() { _loading = true; _error = null; });
    try {
      _reportes = await _reporteService.getReportes(
        usuarioId: usuarioId,
        estado: _filtroEstado,
        aula: _filtroAula,
        tipoAula: _filtroTipoAula,
        busqueda: _busquedaController.text,
      );
    } catch (e) {
      _error = 'Error al cargar reportes';
    } finally {
      setState(() { _loading = false; });
    }
  }

  void _abrirDetalle(Reporte reporte) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalleReporteScreen(reporte: reporte)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mis reportes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearReporteScreen()),
          );
          if (result == true) {
            await _fetchReportes();
          }
        },
        child: const Icon(FontAwesomeIcons.plus),
        tooltip: 'Crear reporte',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(title: const Text('Todos'), onTap: () => Navigator.pop(context, '')),
                          ListTile(title: const Text('Pendiente'), onTap: () => Navigator.pop(context, 'pendiente')),
                          ListTile(title: const Text('Resuelto'), onTap: () => Navigator.pop(context, 'resuelto')),
                        ],
                      ),
                    );
                    if (selected != null) {
                      setState(() { _filtroEstado = selected; });
                      _fetchReportes();
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.flag, size: 18),
                  label: const Text('Estado'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(title: const Text('Todos'), onTap: () => Navigator.pop(context, '')),
                          ListTile(title: const Text('Audiovisual'), onTap: () => Navigator.pop(context, 'AULA AUDIOVISUAL')),
                          ListTile(title: const Text('Digital'), onTap: () => Navigator.pop(context, 'AULA DIGITAL')),
                        ],
                      ),
                    );
                    if (selected != null) {
                      setState(() { _filtroTipoAula = selected; });
                      _fetchReportes();
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.desktop, size: 18),
                  label: const Text('Tipo aula'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final selected = await showModalBottomSheet<String>(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(title: const Text('Todas las aulas'), onTap: () => Navigator.pop(context, '')),
                          ListTile(title: const Text('Aula 101'), onTap: () => Navigator.pop(context, 'AULA 101')),
                          ListTile(title: const Text('Aula 102'), onTap: () => Navigator.pop(context, 'AULA 102')),
                        ],
                      ),
                    );
                    if (selected != null) {
                      setState(() { _filtroAula = selected; });
                      _fetchReportes();
                    }
                  },
                  icon: const Icon(FontAwesomeIcons.school, size: 18),
                  label: const Text('Aula'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
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
                              child: InkWell(
                                onTap: () => _abrirDetalle(reporte),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        reporte.estado == 'pendiente'
                                            ? FontAwesomeIcons.circleExclamation
                                            : FontAwesomeIcons.circleCheck,
                                        color: reporte.estado == 'pendiente' ? Colors.red : Colors.green,
                                        size: 32,
                                      ),
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
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
