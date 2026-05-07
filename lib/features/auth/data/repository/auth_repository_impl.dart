import 'package:bloc_clean_arch/core/failure/app_exception.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/auth_remote_data_source.dart';

/// Concrete implementation of [AuthRepository].
/// 
/// It acts as the single source of truth for the domain layer,
/// coordinating between remote and local data sources.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AppException, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Execute the remote login request
      final user = await remoteDataSource.login(
        email: email,
        password: password,
      );
      
      // Return the successfully mapped user entity
      return Right(user);
    } catch (e) {
      // Handle data-layer errors and convert them to domain exceptions
      return Left(AppException(500, e.toString()));
    }
  }
}
