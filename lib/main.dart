import 'package:flutter/material.dart';
import 'package:expenzia/splash_screen.dart';

void main() {
  runApp(const ExpenziaApp());
}

class ExpenziaApp extends StatelessWidget {
  const ExpenziaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenzia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F7F79),
          primary: const Color(0xFF2F7F79),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
