import 'package:bloc_clean_arch/core/failure/app_exception.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppException, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(AppException(500, e.toString()));
    }
  }

}