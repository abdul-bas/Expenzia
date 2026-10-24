import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class AppTextStyles {
  AppTextStyles._();

  static TextStyle get splashTitle => GoogleFonts.inter(
        fontSize: 50,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
        color: AppColors.white,
      );
}