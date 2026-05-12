import '../repositories/auth_repository.dart';

/// Checks whether the app has a persisted authentication session.
class GetAuthStatusUseCase {
  final AuthRepository _repository;

  GetAuthStatusUseCase(this._repository);

  Future<bool> call() {
    return _repository.hasActiveSession();
  }
}
