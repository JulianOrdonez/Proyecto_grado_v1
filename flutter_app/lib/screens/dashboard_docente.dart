import 'package:flutter/material.dart';

class DashboardDocente extends StatelessWidget {
  const DashboardDocente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Docente')),
      body: Center(child: Text('Reportar fallos y ver estado de salones')),
    );
  }
}

