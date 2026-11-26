abstract class ProfileEvent {
  const ProfileEvent();
}

class LoadProfileEvent extends ProfileEvent {
  const LoadProfileEvent();
}

class UpdateProfileNameEvent extends ProfileEvent {
  final String newName;

  const UpdateProfileNameEvent(this.newName);
}

class ClearStorageEvent extends ProfileEvent {
  const ClearStorageEvent();
}
