import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/usecases/update_transaction_usecase.dart';

class EditTransactionController {
  final UpdateTransactionUseCase updateTransactionUseCase;

  EditTransactionController({
    required this.updateTransactionUseCase,
  });

  /// Opens the Date Picker and returns the selected DateTime or null
  Future<DateTime?> pickDate(
    BuildContext context,
    DateTime currentDate,
  ) async {
    return await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2F7E79),
              onPrimary: Colors.white,
              onSurface: Color(0xFF222222),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Opens a modal bottom sheet to pick between Expense and Income
  Future<bool?> showTypePicker(
    BuildContext context,
    bool currentIsIncome,
  ) async {
    return await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Transaction Type',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.arrow_upward_rounded,
                    color: Color(0xFFF95B51),
                  ),
                  title: const Text(
                    'Expense',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: !currentIsIncome
                      ? const Icon(Icons.check, color: Color(0xFF2F7E79))
                      : null,
                  onTap: () => Navigator.pop(bottomSheetContext, false),
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.arrow_downward_rounded,
                    color: Color(0xFF25A969),
                  ),
                  title: const Text(
                    'Income',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: currentIsIncome
                      ? const Icon(Icons.check, color: Color(0xFF2F7E79))
                      : null,
                  onTap: () => Navigator.pop(bottomSheetContext, true),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Validates and updates the transaction
  Future<void> updateTransaction({
    required int id,
    required String title,
    required double amount,
    required bool isIncome,
    required DateTime date,
    String? category,
  }) async {
    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw Exception('Please enter a name for the transaction');
    }
    if (amount <= 0) {
      throw Exception('Please enter a valid amount');
    }

    final formattedDate = DateFormat('EEE, dd MMM yyyy').format(date);
    final determinedCategory = (category != null && category.trim().isNotEmpty)
        ? category.trim()
        : (isIncome ? 'Income' : 'Expense');

    final updatedEntity = TransactionEntity(
      id: id,
      title: trimmedTitle,
      amount: amount,
      isIncome: isIncome,
      category: determinedCategory,
      date: formattedDate,
      createdAt: date,
    );

    await updateTransactionUseCase(updatedEntity);
  }
}
