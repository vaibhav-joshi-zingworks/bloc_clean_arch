import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';

/// Abstract contract for authentication operations.
/// 
/// Defined in the domain layer to establish a boundary that the 
/// data layer must implement.
abstract class AuthRepository {
  /// Attempts to authenticate a user with their [email] and [password].
  /// 
  /// Returns an [Either] containing an [AppException] on failure or 
  /// a [UserEntity] on success.
  Future<Either<AppException, UserEntity>> login({
    required String email, 
    required String password,
  });
}
