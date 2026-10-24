import 'package:expenzia_app/core/constants/app_colors.dart';
import 'package:expenzia_app/core/constants/app_string.dart';
import 'package:expenzia_app/core/theme/app_text_styles.dart';
import 'package:expenzia_app/features/transaction/presentation/widgets/save_button.dart';
import 'package:expenzia_app/features/transaction/presentation/widgets/transaction_field.dart';
import 'package:expenzia_app/features/transaction/presentation/widgets/transaction_header.dart';
import 'package:flutter/material.dart';


class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const TransactionHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(28, 26, 28, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 31, 20, 31),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x14000000),
                      blurRadius: 35,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const TransactionField(
                      label: AppStrings.transactionType,
                      value: AppStrings.expense,
                      trailing: Icon(
                        Icons.keyboard_arrow_down,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 23),
                    const TransactionField(
                      label: AppStrings.name,
                      value: AppStrings.netflix,
                    ),
                    const SizedBox(height: 23),
                    TransactionField(
                      label: AppStrings.amount,
                      value: AppStrings.amountValue,
                      isActive: true,
                      horizontalPadding: 20,
                      trailing: Text(
                        AppStrings.clear,
                        style: AppTextStyles.clearText,
                      ),
                    ),
                    const SizedBox(height: 23),
                    const TransactionField(
                      label: AppStrings.date,
                      value: AppStrings.dateValue,
                      horizontalPadding: 20,
                      trailing: Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 0, 32, 73),
            child: SaveButton(),
          ),
        ],
      ),
    );
  }
}