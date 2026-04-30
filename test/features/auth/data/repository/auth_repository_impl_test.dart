import 'package:bloc_clean_arch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:bloc_clean_arch/features/auth/data/models/user_model.dart';
import 'package:bloc_clean_arch/features/auth/data/repository/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  final tUserModel = UserModel(id: 1, name: 'Test', email: 'test@test.com');

  test('should return remote data when login is successful', () async {
    // arrange
    when(() => mockRemoteDataSource.login(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => tUserModel);

    // act
    final result = await repository.login(email: 'test@test.com', password: 'password');

    // assert
    expect(result, Right(tUserModel));
    verify(() => mockRemoteDataSource.login(
      email: 'test@test.com',
      password: 'password',
    ));
  });

  test('should return failure when login is unsuccessful', () async {
    // arrange
    when(() => mockRemoteDataSource.login(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenThrow(Exception('error'));

    // act
    final result = await repository.login(email: 'test@test.com', password: 'password');

    // assert
    expect(result.isLeft(), true);
  });
}
