import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/reporte.dart';
import '../services/reporte_service.dart';

class CrearReporteScreen extends StatefulWidget {
  const CrearReporteScreen({super.key});

  @override
  State<CrearReporteScreen> createState() => _CrearReporteScreenState();
}

class _CrearReporteScreenState extends State<CrearReporteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _salonController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _edificioController = TextEditingController();
  final _dependenciaController = TextEditingController();
  final _tipoAulaController = TextEditingController();
  final _sillasController = TextEditingController();
  final ReporteService _reporteService = ReporteService();
  bool _loading = false;
  int? usuarioId;

  Aula? _aulaSeleccionada;

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
  }

  Future<void> _crearReporte() async {
    if (!_formKey.currentState!.validate() || usuarioId == null) return;
    setState(() { _loading = true; });
    try {
      final nuevoReporte = Reporte(
        usuarioId: usuarioId!,
        salon: _salonController.text,
        descripcion: _descripcionController.text,
        estado: 'pendiente',
        fecha: DateTime.now(),
        edificio: _edificioController.text,
        dependencia: _dependenciaController.text,
        tipoAula: _tipoAulaController.text,
        sillas: int.tryParse(_sillasController.text) ?? 0,
      );
      await _reporteService.crearReporte(nuevoReporte);
      _salonController.clear();
      _descripcionController.clear();
      _edificioController.clear();
      _dependenciaController.clear();
      _tipoAulaController.clear();
      _sillasController.clear();
      setState(() { _aulaSeleccionada = null; });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reporte creado correctamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al crear reporte')),
      );
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Crear Reporte'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Selecciona un aula del Bloque D:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: aulasBloqueD.length,
                  itemBuilder: (context, index) {
                    final aula = aulasBloqueD[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _salonController.text = aula.nombre;
                          _edificioController.text = aula.edificio;
                          _dependenciaController.text = aula.dependencia;
                          _tipoAulaController.text = aula.tipo;
                          _sillasController.text = aula.sillas.toString();
                          _aulaSeleccionada = aula;
                        });
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        child: Container(
                          width: 260,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(_getAulaIcon(aula.icono), size: 36),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text('Aula.: ${aula.nombre}', style: const TextStyle(fontWeight: FontWeight.bold))),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text('Edif.: ${aula.edificio} -- Depe.: ${aula.dependencia}'),
                              Text('Tipo Aula: ${aula.tipo} -- Sillas: ${aula.sillas}'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _salonController,
                      decoration: const InputDecoration(labelText: 'Nombre de sala'),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _edificioController,
                      decoration: const InputDecoration(labelText: 'Edificio'),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _dependenciaController,
                      decoration: const InputDecoration(labelText: 'Dependencia'),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _tipoAulaController,
                      decoration: const InputDecoration(labelText: 'Tipo de aula'),
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _sillasController,
                      decoration: const InputDecoration(labelText: 'Sillas'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                    ),
                    TextFormField(
                      controller: _descripcionController,
                      decoration: const InputDecoration(labelText: 'Descripción'),
                      validator: (value) => value == null || value.isEmpty ? 'Campo obligatorio' : null,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _loading ? null : _crearReporte,
                      icon: Icon(FontAwesomeIcons.paperPlane, color: Colors.green),
                      label: _loading ? const Text('Enviando...') : const Text('Enviar reporte'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade100,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Aula {
  final String nombre;
  final String edificio;
  final String dependencia;
  final String tipo;
  final int sillas;
  final IconData icono;
  Aula({required this.nombre, required this.edificio, required this.dependencia, required this.tipo, required this.sillas, required this.icono});
}

final List<Aula> aulasBloqueD = [
  Aula(nombre: 'D101-VIDEO BEAM (226)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 45, icono: Icons.videocam),
  Aula(nombre: 'D103 PANTALLA (269)', edificio: 'BLOQUE D', dependencia: 'CIENCIAS JURÍDICAS Y HUMANÍSTICAS', tipo: 'AULA AUDIOVISUAL', sillas: 35, icono: Icons.image),
  Aula(nombre: 'D104 PANTALLA (228)', edificio: 'BLOQUE D', dependencia: 'CIENCIAS JURÍDICAS Y HUMANÍSTICAS', tipo: 'AULA AUDIOVISUAL', sillas: 40, icono: Icons.image),
  Aula(nombre: 'D105-DIGITAL (229)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA INTERACTIVA', sillas: 60, icono: Icons.laptop),
  Aula(nombre: 'D106-PANTALLA (230)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 60, icono: Icons.image),
  Aula(nombre: 'D107-A-VIDEO BEAM (232)', edificio: 'BLOQUE D', dependencia: 'INGENIERÍA', tipo: 'AULA AUDIOVISUAL', sillas: 55, icono: Icons.videocam),
  Aula(nombre: 'D107-VIDEO BEAM (231)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 45, icono: Icons.videocam),
  Aula(nombre: 'D111-DIGITAL (234)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA INTERACTIVA', sillas: 55, icono: Icons.laptop),
  Aula(nombre: 'D112-PANTALLA (235)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 60, icono: Icons.image),
  Aula(nombre: 'D113-VIDEO BEAM (236)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 60, icono: Icons.videocam),
  Aula(nombre: 'D201-PANTALLA (237)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 70, icono: Icons.image),
  Aula(nombre: 'D202-VIDEO BEAM (238)', edificio: 'BLOQUE D', dependencia: 'INFORMÁTICA', tipo: 'AULA AUDIOVISUAL', sillas: 80, icono: Icons.videocam),
];

// Helper para mapear iconos de Material a FontAwesome
IconData _getAulaIcon(IconData materialIcon) {
  if (materialIcon == Icons.videocam) return FontAwesomeIcons.video;
  if (materialIcon == Icons.image) return FontAwesomeIcons.image;
  if (materialIcon == Icons.laptop) return FontAwesomeIcons.laptop;
  return FontAwesomeIcons.school;
}
