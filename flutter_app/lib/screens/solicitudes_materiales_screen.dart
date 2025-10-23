import 'package:flutter/material.dart';

class SolicitudesMaterialesScreen extends StatelessWidget {
  const SolicitudesMaterialesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitudes de materiales')),
      body: const Center(
        child: Text('Aquí se mostrarán las solicitudes de materiales.'),
      ),
    );
  }
}

