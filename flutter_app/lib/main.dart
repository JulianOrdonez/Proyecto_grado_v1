import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/dashboard_docente.dart';
import 'screens/dashboard_tecnico.dart';
import 'screens/dashboard_admin.dart';
import 'screens/home_admin.dart';
import 'screens/home_docente.dart';
import 'screens/home_tecnico.dart';
// Pantallas principales
import 'screens/reportar_screen.dart';
import 'screens/mis_reportes_screen.dart';
import 'screens/todos_reportes_screen.dart';
import 'screens/dispositivos_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/usuarios_screen.dart';
import 'screens/crear_reporte_screen.dart';
import 'screens/solicitudes_materiales_screen.dart';
import 'screens/solicitud_material_screen.dart';

void main() {
  runApp(const UcevaIotApp());
}

class UcevaIotApp extends StatelessWidget {
  const UcevaIotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCEVA IoT',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartGate(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home_admin': (context) => const HomeAdmin(),
        '/home_docente': (context) => const HomeDocente(),
        '/home_tecnico': (context) => const HomeTecnico(),
        '/reportar': (context) => const ReportarScreen(),
        '/mis_reportes': (context) => const MisReportesScreen(),
        '/todos_reportes': (context) => const TodosReportesScreen(),
        '/dispositivos': (context) => const DispositivosScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/usuarios': (context) => const UsuariosScreen(),
        '/crear_reporte': (context) => const CrearReporteScreen(),
        '/solicitudes_materiales': (context) => const SolicitudesMaterialesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/solicitud_material') {
          final args = settings.arguments as Map<String, dynamic>?;
          final usuarioId = args?['usuarioId'] ?? 0;
          return MaterialPageRoute(
            builder: (context) => SolicitudMaterialScreen(usuarioId: usuarioId),
          );
        }
        // Rutas por defecto
        return null;
      },
    );
  }
}

class StartGate extends StatefulWidget {
  const StartGate({super.key});

  @override
  State<StartGate> createState() => _StartGateState();
}

class _StartGateState extends State<StartGate> {
  @override
  void initState() {
    super.initState();
    _decidirRuta();
  }

  Future<void> _decidirRuta() async {
    final prefs = await SharedPreferences.getInstance();
    final rol = prefs.getString('rol');
    if (rol == 'admin') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home_admin');
    } else if (rol == 'docente') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home_docente');
    } else if (rol == 'tecnico') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/home_tecnico');
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
