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

  static TextStyle get onboardingTitle => GoogleFonts.inter(
        fontSize: 36,
        height: 38 / 36,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.72,
        color: AppColors.green,
      );

  static TextStyle get buttonText => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.36,
        color: AppColors.white,
      );
        static TextStyle get appBarTitle => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  static TextStyle get fieldLabel => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.72,
        color: AppColors.textSecondary,
      );

  static TextStyle get fieldValue => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: -0.14,
        color: AppColors.textSecondary,
      );

  static TextStyle get fieldValueActive => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.14,
        color: AppColors.green,
      );

  static TextStyle get clearText => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.green,
      );
}