import 'package:expenzia/features/profile/domain/repositories/profile_repository.dart';

class ClearStorageUseCase {
  final ProfileRepository repository;

  ClearStorageUseCase(this.repository);

  Future<void> call() async {
    await repository.clearAllStorage();
  }
}
