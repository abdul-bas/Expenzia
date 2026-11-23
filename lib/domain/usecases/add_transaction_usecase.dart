import 'package:expenzia/domain/entities/transaction_entity.dart';
import 'package:expenzia/domain/repositories/transaction_repository.dart';

class AddTransactionUseCase {
  final TransactionRepository repository;

  AddTransactionUseCase(this.repository);

  Future<int> call(TransactionEntity transaction) async {
    return await repository.addTransaction(transaction);
  }
}
