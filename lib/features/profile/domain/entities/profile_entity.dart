class ProfileEntity {
  final int id;
  final String name;
  final String avatarPath;

  const ProfileEntity({
    this.id = 1,
    required this.name,
    this.avatarPath = 'assets/images/profile_avatar.png',
  });

  ProfileEntity copyWith({
    int? id,
    String? name,
    String? avatarPath,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }
}
