import 'package:flutter/material.dart';
import 'package:expenzia/core/constants/app_colors.dart';
import 'package:expenzia/core/constants/app_strings.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    this.onPressed,
    this.text = AppStrings.getStarted,
  });

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: AppColors.buttonGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.buttonShadow.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.36,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
