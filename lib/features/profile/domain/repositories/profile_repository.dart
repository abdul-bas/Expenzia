import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile();
  Future<void> updateProfileName(String name);
  Future<void> clearAllStorage();
}
