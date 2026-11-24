import 'package:expenzia/core/database/database_helper.dart';
import 'package:expenzia/features/credit/data/models/credit_model.dart';
import 'package:expenzia/features/credit/domain/entities/credit_entity.dart';
import 'package:expenzia/features/credit/domain/repositories/credit_repository.dart';

class CreditRepositoryImpl implements CreditRepository {
  final DatabaseHelper databaseHelper;

  CreditRepositoryImpl({DatabaseHelper? dbHelper})
      : databaseHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<List<CreditEntity>> getCredits() async {
    final maps = await databaseHelper.queryAll('credits');
    return maps.map((map) => CreditModel.fromMap(map)).toList();
  }

  @override
  Future<int> addCredit(CreditEntity credit) async {
    final model = CreditModel.fromEntity(credit);
    return await databaseHelper.insert('credits', model.toMap());
  }

  @override
  Future<int> deleteCredit(int id) async {
    return await databaseHelper.delete('credits', id);
  }
}
