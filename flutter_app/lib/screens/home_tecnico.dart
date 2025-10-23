import 'package:flutter/material.dart';

class HomeTecnico extends StatelessWidget {
  const HomeTecnico({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio Técnico')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/todos_reportes'),
              child: const Text('Ver todos los reportes'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/dispositivos'),
              child: const Text('Ver dispositivos y consumo'),
            ),
          ],
        ),
      ),
    );
  }
}

