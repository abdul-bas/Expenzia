import 'package:expenzia/domain/entities/transaction_entity.dart';
import 'package:expenzia/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() async {
    return await repository.getTransactions();
  }
}
