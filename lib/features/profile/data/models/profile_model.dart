import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.id,
    required super.name,
    super.avatarPath,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: (map['id'] as int?) ?? 1,
      name: (map['name'] as String?) ?? 'Sahal Muhammed',
      avatarPath: (map['avatar_path'] as String?) ??
          'assets/images/profile_avatar.png',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar_path': avatarPath,
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      name: entity.name,
      avatarPath: entity.avatarPath,
    );
  }
}
