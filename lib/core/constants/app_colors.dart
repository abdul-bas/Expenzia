import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette from Figma
  static const Color primary = Color(0xFF2F7F79);
  static const Color primaryDark = Color(0xFF256863);
  static const Color primaryLight = Color(0xFF5FA8A1);
  static const Color primaryTint = Color(0xFFE3F1EF);

  // Gradient Colors from Figma Splash Screen (153.16 deg)
  static const Color splashGradientStart = Color(0xFF63B5AF); // rgb(99, 181, 175)
  static const Color splashGradientEnd = Color(0xFF438883);   // rgb(67, 136, 131)

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment(-0.45, -0.9),
    end: Alignment(0.45, 0.9),
    colors: [splashGradientStart, splashGradientEnd],
    stops: [0.045, 1.0],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  // Background and surface
  static const Color background = Color(0xFFF5F8F8);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1C2B2A);
  static const Color textSecondary = Color(0xFF6B7C7B);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
}
