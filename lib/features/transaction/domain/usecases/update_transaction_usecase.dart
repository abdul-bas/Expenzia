import 'package:expenzia/features/transaction/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/transaction/domain/repositories/transaction_repository.dart';

class UpdateTransactionUseCase {
  final TransactionRepository repository;

  UpdateTransactionUseCase(this.repository);

  Future<int> call(TransactionEntity transaction) async {
    return await repository.updateTransaction(transaction);
  }
}
