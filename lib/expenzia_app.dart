

import 'package:expenzia_app/features/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';


class ExpenziaApp extends StatelessWidget {
  const ExpenziaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Home',
     
      home: const SplashPage(),
    );
  }
}