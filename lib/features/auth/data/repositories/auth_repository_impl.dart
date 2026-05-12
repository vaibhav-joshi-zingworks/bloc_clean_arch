import 'package:bloc_clean_arch/core/failure/app_exception.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/auth_session_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../mappers/auth_session_mapper.dart';

/// Coordinates remote authentication with local session persistence.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  @override
  Future<Either<AppException, AuthSessionEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        email: email,
        password: password,
      );
      final session = AuthSessionMapper.fromLoginResponse(response);

      await _localDataSource.saveSession(session);

      return Right(session);
    } catch (e) {
      return Left(AppException(500, e.toString()));
    }
  }

  @override
  Future<Either<AppException, void>> logout() async {
    try {
      await _localDataSource.clearSession();
      return const Right(null);
    } catch (e) {
      return Left(AppException(500, e.toString()));
    }
  }

  @override
  Future<bool> hasActiveSession() async {
    final token = await _localDataSource.getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
