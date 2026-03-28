import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resuelvo_flutter/features/login/login_page.dart';
import 'package:resuelvo_flutter/features/login/welcome_page.dart';
import 'package:resuelvo_flutter/services/parse_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Parse Server
  await ParseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resuelvo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}