import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';


class TransactionField extends StatelessWidget {
  const TransactionField({
    super.key,
    required this.label,
    required this.value,
    this.trailing,
    this.isActive = false,
    this.horizontalPadding = 16,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final bool isActive;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.fieldLabel),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.green : AppColors.border,
              width: isActive ? 1.4 : 1,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: isActive
                      ? AppTextStyles.fieldValueActive
                      : AppTextStyles.fieldValue,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ],
    );
  }
}