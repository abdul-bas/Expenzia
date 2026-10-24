import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/constants/app_string.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';


class SaveButton extends StatelessWidget {
  const SaveButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Text(AppStrings.save, style: AppTextStyles.buttonText),
      ),
    );
  }
}