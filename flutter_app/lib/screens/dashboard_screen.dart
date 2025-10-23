import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard energético')),
      body: Center(child: Text('Gráficas y estadísticas de consumo energético (admin)')),
    );
  }
}

