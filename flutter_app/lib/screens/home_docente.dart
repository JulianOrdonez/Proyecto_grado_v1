import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'notificaciones_screen.dart';

class HomeDocente extends StatelessWidget {
  const HomeDocente({super.key});

  Future<void> _abrirNotificaciones(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final usuarioId = prefs.getInt('usuarioId');
    if (usuarioId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificacionesScreen(usuarioId: usuarioId),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el usuario.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio Docente')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/crear_reporte'),
              icon: const Icon(FontAwesomeIcons.book, color: Colors.red),
              label: const Text('Reportar fallo en salón'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/mis_reportes'),
              icon: const Icon(FontAwesomeIcons.fileAlt, color: Colors.blue),
              label: const Text('Ver mis reportes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                final usuarioId = prefs.getInt('usuarioId');
                if (usuarioId != null) {
                  Navigator.pushNamed(
                    context,
                    '/solicitud_material',
                    arguments: {'usuarioId': usuarioId},
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No se encontró el usuario.')),
                  );
                }
              },
              icon: const Icon(FontAwesomeIcons.boxOpen, color: Colors.green),
              label: const Text('Solicitar materiales'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade100,
                foregroundColor: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _abrirNotificaciones(context),
              icon: const Icon(FontAwesomeIcons.bell, color: Colors.deepPurple),
              label: const Text('Notificaciones'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple.shade100,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
