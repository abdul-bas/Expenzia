import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';
import 'package:expenzia/features/credit/domain/repositories/credit_repository.dart';

class AddCreditUseCase {
  final CreditRepository repository;

  AddCreditUseCase(this.repository);

  Future<int> call(CreditEntity credit) async {
    return await repository.addCredit(credit);
  }
}
