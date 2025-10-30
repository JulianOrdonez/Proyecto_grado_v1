import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class HomeTecnico extends StatelessWidget {
  const HomeTecnico({super.key});

  Future<void> _logout(BuildContext context) async {
    await AuthService().logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('usuarioId');
    await prefs.remove('rol');
    await prefs.remove('nombre');
    await prefs.remove('email');
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio Técnico'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const FaIcon(FontAwesomeIcons.powerOff),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(FontAwesomeIcons.screwdriverWrench, size: 72, color: Colors.teal),
              const SizedBox(height: 8),
              Text('Técnico', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/todos_reportes'),
                icon: const FaIcon(FontAwesomeIcons.clipboardList),
                label: const Text('Ver todos los reportes'),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/dispositivos'),
                icon: const FaIcon(FontAwesomeIcons.microchip),
                label: const Text('Ver dispositivos y consumo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
