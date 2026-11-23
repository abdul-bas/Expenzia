import 'package:expenzia/features/home/domain/entities/transaction_entity.dart';
import 'package:expenzia/features/home/domain/repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  final TransactionRepository repository;

  GetTransactionsUseCase(this.repository);

  Future<List<TransactionEntity>> call() async {
    return await repository.getTransactions();
  }
}
