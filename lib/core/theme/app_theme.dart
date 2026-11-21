import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String fontFamily = 'Inter';

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      brightness: Brightness.light,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
  );
}
