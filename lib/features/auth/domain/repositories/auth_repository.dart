import 'package:bloc_clean_arch/core.dart';

import '../entities/auth_session_entity.dart';

/// Contract for authentication operations in the domain layer.
abstract class AuthRepository {
  Future<Either<AppException, AuthSessionEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<AppException, void>> logout();

  Future<bool> hasActiveSession();
}
