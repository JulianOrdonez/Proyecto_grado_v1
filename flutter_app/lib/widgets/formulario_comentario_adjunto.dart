import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FormularioComentarioAdjunto extends StatefulWidget {
  final int reporteId;
  final VoidCallback onComentarioAgregado;
  const FormularioComentarioAdjunto({required this.reporteId, required this.onComentarioAgregado, super.key});

  @override
  State<FormularioComentarioAdjunto> createState() => _FormularioComentarioAdjuntoState();
}

class _FormularioComentarioAdjuntoState extends State<FormularioComentarioAdjunto> {
  final _comentarioController = TextEditingController();
  String? _archivoPath;
  bool _loading = false;

  Future<void> _enviarComentario() async {
    setState(() { _loading = true; });
    // Aquí deberías llamar a tu servicio para enviar el comentario y el adjunto
    // await ComentarioService().agregarComentario(widget.reporteId, _comentarioController.text, archivoPath: _archivoPath);
    setState(() { _loading = false; });
    widget.onComentarioAgregado();
    _comentarioController.clear();
    setState(() { _archivoPath = null; });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _comentarioController,
          decoration: const InputDecoration(labelText: 'Comentario'),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                // Aquí deberías implementar la selección de archivo
                // Por ejemplo, usando file_picker
              },
              icon: const Icon(FontAwesomeIcons.paperclip),
              label: Text(_archivoPath == null ? 'Adjuntar archivo' : 'Archivo seleccionado'),
            ),
            if (_archivoPath != null)
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(_archivoPath!),
              ),
          ],
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: _loading ? null : _enviarComentario,
          child: _loading ? const CircularProgressIndicator() : const Text('Enviar'),
        ),
      ],
    );
  }
}
