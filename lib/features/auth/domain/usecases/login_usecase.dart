import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';

import '../../../../core.dart';
import '../repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity,LoginParams> {
  final AuthRepository repository;

  LoginUseCase({
    required this.repository,
  });

  @override
  Future<Either<AppException, UserEntity>> call(LoginParams params) async {
    return await repository.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;
  LoginParams({
    required this.email,
    required this.password,
  });
}