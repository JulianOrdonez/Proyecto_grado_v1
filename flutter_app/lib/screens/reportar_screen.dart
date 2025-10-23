import 'package:flutter/material.dart';

class ReportarScreen extends StatelessWidget {
  const ReportarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar fallo en salón')),
      body: Center(child: Text('Formulario para reportar fallos (docente)')),
    );
  }
}

