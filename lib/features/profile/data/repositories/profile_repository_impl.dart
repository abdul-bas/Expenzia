import 'package:expenzia/core/database/database_helper.dart';
import 'package:expenzia/features/profile/data/models/profile_model.dart';
import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';
import 'package:expenzia/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final DatabaseHelper databaseHelper;

  ProfileRepositoryImpl({DatabaseHelper? dbHelper})
      : databaseHelper = dbHelper ?? DatabaseHelper.instance;

  @override
  Future<ProfileEntity> getProfile() async {
    final map = await databaseHelper.getProfile();
    if (map != null) {
      return ProfileModel.fromMap(map);
    }
    return const ProfileEntity(name: 'Sahal Muhammed');
  }

  @override
  Future<void> updateProfileName(String name) async {
    await databaseHelper.updateProfileName(name);
  }

  @override
  Future<void> clearAllStorage() async {
    await databaseHelper.clearAllStorage();
  }
}
