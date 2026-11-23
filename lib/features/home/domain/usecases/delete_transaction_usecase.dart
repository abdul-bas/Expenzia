import 'package:expenzia/features/home/domain/repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  final TransactionRepository repository;

  DeleteTransactionUseCase(this.repository);

  Future<int> call(int id) async {
    return await repository.deleteTransaction(id);
  }
}
