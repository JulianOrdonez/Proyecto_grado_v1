import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.chartLine, size: 20),
            SizedBox(width: 8),
            Text('Dashboard energético'),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FaIcon(FontAwesomeIcons.bolt, size: 56, color: Colors.amber),
            SizedBox(height: 12),
            Text('Gráficas y estadísticas de consumo energético (admin)'),
          ],
        ),
      ),
    );
  }
}
