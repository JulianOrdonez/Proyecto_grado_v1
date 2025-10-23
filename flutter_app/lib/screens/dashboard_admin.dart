import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.bolt, size: 22),
            SizedBox(width: 8),
            Text('Panel Administrador'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(FontAwesomeIcons.chartLine, size: 48, color: Colors.green),
            SizedBox(height: 16),
            Text('Vista global, gestión de usuarios y dispositivos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 24),
            FaIcon(FontAwesomeIcons.usersCog, size: 32, color: Colors.blue),
            SizedBox(height: 8),
            Text('Gestión avanzada'),
          ],
        ),
      ),
    );
  }
}
