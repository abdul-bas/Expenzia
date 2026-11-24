import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:expenzia/core/routes/app_routes.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_bloc.dart';
import 'package:expenzia/features/expense/presentation/bloc/expense_event.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:expenzia/features/transaction/domain/usecases/get_transactions_usecase.dart';

class ExpenseController {
  final GetTransactionsUseCase getTransactionsUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  ExpenseController({
    required this.getTransactionsUseCase,
    required this.deleteTransactionUseCase,
  });

  /// Loads all transactions from SQLite database
  Future<List<TransactionEntity>> loadTransactions() async {
    return await getTransactionsUseCase();
  }

  /// Deletes a transaction by id and returns the updated list
  Future<List<TransactionEntity>> deleteTransaction(int id) async {
    await deleteTransactionUseCase(id);
    return await getTransactionsUseCase();
  }

  /// Formats amount into standard currency string
  String formatAmount(double amount) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(amount);
  }

  /// Shows confirmation dialog and returns whether user confirmed
  Future<bool> confirmDelete(
    BuildContext context,
    TransactionEntity transaction,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text('Are you sure you want to delete "${transaction.title}"?'),
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
    return result ?? false;
  }

  /// Handles delete logic with confirmation and dispatches BLoC event
  Future<void> handleDelete(
    BuildContext context,
    TransactionEntity transaction,
  ) async {
    if (transaction.id == null) return;
    final confirmed = await confirmDelete(context, transaction);
    if (confirmed && context.mounted) {
      context
          .read<ExpenseBloc>()
          .add(DeleteExpenseTransactionEvent(transaction.id!));
    }
  }

  /// Navigates to Edit screen passing the selected transaction
  Future<void> navigateToEdit(
    BuildContext context,
    TransactionEntity transaction,
  ) async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.editTransaction,
      arguments: transaction,
    );
    if (result == true && context.mounted) {
      context.read<ExpenseBloc>().add(const LoadExpenseTransactionsEvent());
    }
  }

  /// Navigates to Add Transaction screen
  Future<void> navigateToAdd(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AppRoutes.transaction);
    if (result == true && context.mounted) {
      context.read<ExpenseBloc>().add(const LoadExpenseTransactionsEvent());
    }
  }
}
