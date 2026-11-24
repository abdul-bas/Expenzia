import 'package:expenzia/features/credit/domain/repositories/credit_repository.dart';

class DeleteCreditUseCase {
  final CreditRepository repository;

  DeleteCreditUseCase(this.repository);

  Future<int> call(int id) async {
    return await repository.deleteCredit(id);
  }
}
