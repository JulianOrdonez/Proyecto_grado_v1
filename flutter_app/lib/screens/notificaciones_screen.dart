import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/notificacion.dart';
import '../services/notificacion_service.dart';

class NotificacionesScreen extends StatefulWidget {
  final int usuarioId;
  const NotificacionesScreen({required this.usuarioId, super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  List<Notificacion> _notificaciones = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _fetchNotificaciones();
  }

  Future<void> _fetchNotificaciones() async {
    setState(() { _loading = true; });
    final notificaciones = await NotificacionService().getNotificaciones(widget.usuarioId);
    setState(() {
      _notificaciones = notificaciones;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notificaciones'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _notificaciones.length,
              itemBuilder: (context, index) {
                final n = _notificaciones[index];
                return ListTile(
                  title: Text(n.mensaje),
                  subtitle: Text('${n.tipo} - ${n.fecha.toLocal()}'),
                  trailing: n.leida ? null : const Icon(FontAwesomeIcons.bell, color: Colors.red),
                );
              },
            ),
    );
  }
}
