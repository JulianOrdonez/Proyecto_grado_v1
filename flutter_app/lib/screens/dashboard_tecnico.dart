import 'package:flutter/material.dart';

class DashboardTecnico extends StatelessWidget {
  const DashboardTecnico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Técnico')),
      body: Center(child: Text('Ver reportes, detalles técnicos y logs de consumo')),
    );
  }
}

