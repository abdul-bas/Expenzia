import 'package:expenzia/features/profile/domain/entities/profile_entity.dart';
import 'package:expenzia/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<ProfileEntity> call() async {
    return await repository.getProfile();
  }
}
