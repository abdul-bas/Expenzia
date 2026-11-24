import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';

abstract class CreditRepository {
  Future<List<CreditEntity>> getCredits();
  Future<int> addCredit(CreditEntity credit);
  Future<int> deleteCredit(int id);
}
