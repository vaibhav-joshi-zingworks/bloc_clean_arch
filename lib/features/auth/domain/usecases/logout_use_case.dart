import 'package:bloc_clean_arch/core.dart';

import '../repositories/auth_repository.dart';

/// Clears the active authentication session.
class LogoutUseCase implements UseCase<void, NoParams> {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<AppException, void>> call(NoParams params) {
    return _repository.logout();
  }
}
