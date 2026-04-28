import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<AppException,UserEntity>> login({required String email, required String password});
}