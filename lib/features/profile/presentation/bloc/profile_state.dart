import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final ProfileEntity profile;

  const ProfileLoaded({required this.profile});
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);
}
