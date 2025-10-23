import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/reporte.dart';
import '../models/comentario.dart';
import '../services/comentario_service.dart';
import '../widgets/formulario_comentario_adjunto.dart';

class DetalleReporteScreen extends StatefulWidget {
  final Reporte reporte;
  const DetalleReporteScreen({required this.reporte, super.key});

  @override
  State<DetalleReporteScreen> createState() => _DetalleReporteScreenState();
}

class _DetalleReporteScreenState extends State<DetalleReporteScreen> {
  List<Comentario> _comentarios = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchHistorial();
  }

  Future<void> _fetchHistorial() async {
    setState(() { _loading = true; });
    final comentarios = await ComentarioService().getHistorial(widget.reporte.id!);
    setState(() {
      _comentarios = comentarios;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del reporte')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('Aula: ${widget.reporte.salon}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Edificio: ${widget.reporte.edificio}'),
                Text('Dependencia: ${widget.reporte.dependencia}'),
                Text('Tipo de aula: ${widget.reporte.tipoAula}'),
                Text('Sillas: ${widget.reporte.sillas}'),
                const SizedBox(height: 8),
                Text('Descripción: ${widget.reporte.descripcion}'),
                Text('Estado: ${widget.reporte.estado}'),
                Text('Fecha: ${widget.reporte.fecha.toLocal()}'),
                const Divider(),
                const Text('Historial de comentarios:', style: TextStyle(fontWeight: FontWeight.bold)),
                ..._comentarios.map((c) => ListTile(
                  title: Text(c.comentario),
                  subtitle: Text('${c.usuario} - ${c.fecha.toLocal()}'),
                  trailing: c.archivoUrl != null ? Icon(FontAwesomeIcons.paperclip) : null,
                )),
                const SizedBox(height: 16),
                const Text('Agregar comentario o adjunto:', style: TextStyle(fontWeight: FontWeight.bold)),
                FormularioComentarioAdjunto(
                  reporteId: widget.reporte.id!,
                  onComentarioAgregado: _fetchHistorial,
                ),
              ],
            ),
    );
  }
}
