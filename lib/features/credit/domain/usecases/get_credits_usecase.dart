import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';
import 'package:expenzia/features/credit/domain/repositories/credit_repository.dart';

class GetCreditsUseCase {
  final CreditRepository repository;

  GetCreditsUseCase(this.repository);

  Future<List<CreditEntity>> call() async {
    return await repository.getCredits();
  }
}
