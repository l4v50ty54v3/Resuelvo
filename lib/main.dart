import 'package:flutter/material.dart';
import 'package:resuelvo_flutter/features/login/login_page.dart';
import 'package:resuelvo_flutter/features/login/welcome_page.dart';

void main() {
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
      ),
      home: const WelcomePage(),
    );
  }
}