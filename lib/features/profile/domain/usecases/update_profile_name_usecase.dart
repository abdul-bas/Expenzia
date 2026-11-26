import 'package:expenzia/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileNameUseCase {
  final ProfileRepository repository;

  UpdateProfileNameUseCase(this.repository);

  Future<void> call(String name) async {
    await repository.updateProfileName(name);
  }
}
