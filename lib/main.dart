import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/screens/main_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vize',
      theme: ThemeData(
         useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A69FF),
          background: const Color(0xFFF5F7FA),
        ),
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xFF1E2A51),
          displayColor: const Color(0xFF1E2A51),
        )
      ),
      home: const MainScreen(),
    );
  }
}
