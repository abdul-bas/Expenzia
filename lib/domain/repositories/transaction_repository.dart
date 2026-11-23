import 'package:expenzia/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<List<TransactionEntity>> getTransactions();
  Future<int> addTransaction(TransactionEntity transaction);
  Future<int> deleteTransaction(int id);
}
