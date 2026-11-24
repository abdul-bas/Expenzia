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
}
