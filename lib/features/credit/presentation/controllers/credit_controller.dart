import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';
import 'package:expenzia/features/credit/domain/usecases/add_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/delete_credit_usecase.dart';
import 'package:expenzia/features/credit/domain/usecases/get_credits_usecase.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_bloc.dart';
import 'package:expenzia/features/credit/presentation/bloc/credit_event.dart';

class CreditController {
  final GetCreditsUseCase getCreditsUseCase;
  final AddCreditUseCase addCreditUseCase;
  final DeleteCreditUseCase deleteCreditUseCase;

  CreditController({
    required this.getCreditsUseCase,
    required this.addCreditUseCase,
    required this.deleteCreditUseCase,
  });

  /// Loads all credits from SQLite
  Future<List<CreditEntity>> loadCredits() async {
    return await getCreditsUseCase();
  }

  /// Formats amount into standard currency string
  String formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  /// Opens the Date Picker and returns selected date or null
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

  /// Opens modal sheet to pick Credit Type
  Future<String?> showCreditTypePicker(
    BuildContext context,
    String currentType,
  ) async {
    const types = [
      'Subscriptions',
      'Loans',
      'Credit Card',
      'Bills',
      'Insurance',
      'Other',
    ];

    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Credit Type',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 12),
                ...types.map((type) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        type,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: type == currentType
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: type == currentType
                              ? const Color(0xFF2F7E79)
                              : const Color(0xFF333333),
                        ),
                      ),
                      trailing: type == currentType
                          ? const Icon(Icons.check, color: Color(0xFF2F7E79))
                          : null,
                      onTap: () => Navigator.pop(sheetContext, type),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Opens modal sheet to pick Plan Type
  Future<String?> showPlanTypePicker(
    BuildContext context,
    String currentPlan,
  ) async {
    const plans = [
      'Monthly',
      'One-time',
      'Yearly',
      'Weekly',
      'Quarterly',
    ];

    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Select Plan Type',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
                const SizedBox(height: 12),
                ...plans.map((plan) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        plan,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: plan == currentPlan
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: plan == currentPlan
                              ? const Color(0xFF2F7E79)
                              : const Color(0xFF333333),
                        ),
                      ),
                      trailing: plan == currentPlan
                          ? const Icon(Icons.check, color: Color(0xFF2F7E79))
                          : null,
                      onTap: () => Navigator.pop(sheetContext, plan),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Validates and saves credit entry
  Future<void> saveCredit({
    required String creditType,
    required String toName,
    required double amount,
    required DateTime date,
    required String planType,
  }) async {
    final trimmedTo = toName.trim();
    if (trimmedTo.isEmpty) {
      throw Exception('Please enter the recipient or provider (TO)');
    }
    if (amount <= 0) {
      throw Exception('Please enter a valid positive amount');
    }

    final formattedDate = 'Due on ${DateFormat('dd/MM/yy').format(date)}';
    final credit = CreditEntity(
      creditType: creditType,
      toName: trimmedTo,
      amount: amount,
      dueDate: formattedDate,
      planType: planType,
      createdAt: date,
    );

    await addCreditUseCase(credit);
  }

  /// Shows confirmation dialog and deletes credit
  Future<void> confirmAndDelete(
    BuildContext context,
    CreditEntity credit,
  ) async {
    if (credit.id == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Credit Entry'),
        content: Text('Are you sure you want to delete "${credit.toName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<CreditBloc>().add(DeleteCreditEvent(credit.id!));
    }
  }
}
