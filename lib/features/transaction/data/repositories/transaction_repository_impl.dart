import 'package:expenzia/core/database/database_helper.dart';
import 'package:expenzia/features/transaction/data/models/transaction_model.dart';
import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final DatabaseHelper databaseHelper;

  TransactionRepositoryImpl({DatabaseHelper? dbHelper})
      : databaseHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<List<TransactionEntity>> getTransactions() async {
    final maps = await databaseHelper.queryAll('transactions');
    return maps.map((map) => TransactionModel.fromMap(map)).toList();
  }

  @override
  Future<int> addTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    return await databaseHelper.insert('transactions', model.toMap());
  }

  @override
  Future<int> updateTransaction(TransactionEntity transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    return await databaseHelper.update(
      'transactions',
      model.toMap(),
      transaction.id!,
    );
  }

  @override
  Future<int> deleteTransaction(int id) async {
    return await databaseHelper.delete('transactions', id);
  }
}
