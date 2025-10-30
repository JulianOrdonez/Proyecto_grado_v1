import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dispositivo.dart';
import '../services/dispositivo_service.dart';
import '../services/auth_service.dart';

class DispositivosScreen extends StatefulWidget {
  const DispositivosScreen({super.key});

  @override
  State<DispositivosScreen> createState() => _DispositivosScreenState();
}

class _DispositivosScreenState extends State<DispositivosScreen> {
  final DispositivoService _dispositivoService = DispositivoService();
  List<Dispositivo> _dispositivos = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchDispositivos();
  }

  Future<void> _logout() async {
    await AuthService().logout();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  Future<void> _fetchDispositivos() async {
    setState(() { _loading = true; _error = null; });
    try {
      _dispositivos = await _dispositivoService.getDispositivos();
    } catch (e) {
      _error = 'Error al cargar dispositivos';
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            FaIcon(FontAwesomeIcons.microchip, size: 22),
            SizedBox(width: 8),
            Text('Dispositivos y consumo'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const FaIcon(FontAwesomeIcons.powerOff),
            onPressed: _logout,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _error != null
                ? Center(child: Text(_error!))
                : ListView.builder(
                    itemCount: _dispositivos.length,
                    itemBuilder: (context, index) {
                      final dispositivo = _dispositivos[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: const FaIcon(FontAwesomeIcons.microchip, size: 28),
                          title: Text(dispositivo.tipo),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Ubicación: ${dispositivo.ubicacion}'),
                              Text('Estado: ${dispositivo.estado}'),
                              Text('Consumo: ${dispositivo.consumo} kWh'),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
