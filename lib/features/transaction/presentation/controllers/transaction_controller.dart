import 'package:intl/intl.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/usecases/add_transaction_usecase.dart';

class TransactionController {
  final AddTransactionUseCase addTransactionUseCase;

  TransactionController({
    required this.addTransactionUseCase,
  });

  /// Validates and saves a transaction.
  Future<void> saveTransaction({
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

    final transaction = TransactionEntity(
      title: trimmedTitle,
      amount: amount,
      isIncome: isIncome,
      category: determinedCategory,
      date: formattedDate,
      createdAt: date,
    );

    await addTransactionUseCase(transaction);
  }
}
