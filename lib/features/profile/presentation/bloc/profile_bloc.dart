import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expenzia/features/profile/domain/usecases/clear_storage_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:expenzia/features/profile/domain/usecases/update_profile_name_usecase.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_event.dart';
import 'package:expenzia/features/profile/presentation/bloc/profile_state.dart';
import 'package:expenzia/features/profile/presentation/controllers/profile_controller.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileController _controller;

  ProfileBloc({
    required GetProfileUseCase getProfileUseCase,
    required UpdateProfileNameUseCase updateProfileNameUseCase,
    required ClearStorageUseCase clearStorageUseCase,
  })  : _controller = ProfileController(
          getProfileUseCase: getProfileUseCase,
          updateProfileNameUseCase: updateProfileNameUseCase,
          clearStorageUseCase: clearStorageUseCase,
        ),
        super(const ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
    on<UpdateProfileNameEvent>(_onUpdateName);
    on<ClearStorageEvent>(_onClearStorage);
  }

  Future<void> _onLoadProfile(
    LoadProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      final profile = await _controller.loadProfile();
      emit(ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateName(
    UpdateProfileNameEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await _controller.updateProfileName(event.newName);
      final updated = await _controller.loadProfile();
      emit(ProfileLoaded(profile: updated));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onClearStorage(
    ClearStorageEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileLoading());
    try {
      await _controller.clearAllStorage();
      final resetProfile = await _controller.loadProfile();
      emit(ProfileLoaded(profile: resetProfile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
