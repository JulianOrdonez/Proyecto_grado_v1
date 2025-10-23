import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio Admin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/dashboard'),
              icon: const FaIcon(FontAwesomeIcons.chartLine),
              label: const Text('Dashboard energético'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/usuarios'),
              icon: const FaIcon(FontAwesomeIcons.usersCog),
              label: const Text('Gestionar usuarios y roles'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/todos_reportes'),
              icon: const FaIcon(FontAwesomeIcons.clipboardList),
              label: const Text('Ver todos los reportes'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/dispositivos'),
              icon: const FaIcon(FontAwesomeIcons.microchip),
              label: const Text('Ver dispositivos y consumo'),
            ),
          ],
        ),
      ),
    );
  }
}
