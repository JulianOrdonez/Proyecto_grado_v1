import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/solicitud_material.dart';
import '../services/material_service.dart';

class SolicitudMaterialScreen extends StatefulWidget {
  final int usuarioId;
  const SolicitudMaterialScreen({required this.usuarioId, super.key});

  @override
  State<SolicitudMaterialScreen> createState() => _SolicitudMaterialScreenState();
}

class _SolicitudMaterialScreenState extends State<SolicitudMaterialScreen> {
  List<SolicitudMaterial> _solicitudes = [];
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final _tipoController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchSolicitudes();
  }

  Future<void> _fetchSolicitudes() async {
    setState(() { _loading = true; });
    final solicitudes = await MaterialService().getSolicitudes(widget.usuarioId);
    setState(() {
      _solicitudes = solicitudes;
      _loading = false;
    });
  }

  Future<void> _crearSolicitud() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; });
    final ok = await MaterialService().crearSolicitud(
      widget.usuarioId,
      _tipoController.text,
      int.tryParse(_cantidadController.text) ?? 0,
      _descripcionController.text,
    );
    if (ok) {
      _tipoController.clear();
      _cantidadController.clear();
      _descripcionController.clear();
      await _fetchSolicitudes();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitud creada correctamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear solicitud')),
      );
    }
    setState(() { _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Solicitud de materiales'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _tipoController,
                            decoration: const InputDecoration(labelText: 'Tipo de material'),
                            validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
                          ),
                          TextFormField(
                            controller: _cantidadController,
                            decoration: const InputDecoration(labelText: 'Cantidad'),
                            keyboardType: TextInputType.number,
                            validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
                          ),
                          TextFormField(
                            controller: _descripcionController,
                            decoration: const InputDecoration(labelText: 'Descripción'),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: _crearSolicitud,
                            child: const Text('Solicitar material'),
                          ),
                          const Divider(height: 32),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _solicitudes.length,
                      itemBuilder: (context, index) {
                        final s = _solicitudes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          child: ListTile(
                            title: Text('${s.tipoMaterial} (${s.cantidad})'),
                            subtitle: Text('${s.descripcion}\nEstado: ${s.estado}\nFecha: ${s.fecha.toLocal()}'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
