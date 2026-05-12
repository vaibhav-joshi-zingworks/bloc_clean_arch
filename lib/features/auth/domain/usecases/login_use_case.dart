import 'package:bloc_clean_arch/core.dart';

import '../entities/auth_session_entity.dart';
import '../repositories/auth_repository.dart';

/// Parameters required to execute [LoginUseCase].
class LoginParams {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });
}

/// Authenticates a user and returns a persisted session.
class LoginUseCase implements UseCase<AuthSessionEntity, LoginParams> {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<AppException, AuthSessionEntity>> call(LoginParams params) {
    return _repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
