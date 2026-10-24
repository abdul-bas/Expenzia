import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/constants/app_string.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';


class TransactionHeader extends StatelessWidget {
  const TransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 134,
      width: double.infinity,
      color: AppColors.primary,
      child: Stack(
        children: [
          Positioned(
            left: 24,
            top: 81,
            child: GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: const Icon(
                Icons.chevron_left,
                size: 28,
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 84,
            child: Text(
              AppStrings.transaction,
              textAlign: TextAlign.center,
              style: AppTextStyles.appBarTitle,
            ),
          ),
        ],
      ),
    );
  }
}