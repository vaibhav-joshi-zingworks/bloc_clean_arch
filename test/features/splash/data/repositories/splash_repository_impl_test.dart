import 'package:bloc_clean_arch/features/splash/data/datasource/splash_local_data_source.dart';
import 'package:bloc_clean_arch/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashLocalDataSource extends Mock implements SplashLocalDataSource {}

void main() {
  late SplashRepositoryImpl repository;
  late MockSplashLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockSplashLocalDataSource();
    repository = SplashRepositoryImpl(mockLocalDataSource);
  });

  test('should return firstLaunch when isFirstLaunch is true', () async {
    // arrange
    when(() => mockLocalDataSource.isFirstLaunch()).thenAnswer((_) async => true);
    // act
    final result = await repository.getAppStatus();
    // assert
    expect(result, AppStatus.firstLaunch);
  });

  test('should return authenticated when token is present', () async {
    // arrange
    when(() => mockLocalDataSource.isFirstLaunch()).thenAnswer((_) async => false);
    when(() => mockLocalDataSource.getToken()).thenAnswer((_) async => 'token');
    // act
    final result = await repository.getAppStatus();
    // assert
    expect(result, AppStatus.authenticated);
  });

  test('should return unauthenticated when token is null', () async {
    // arrange
    when(() => mockLocalDataSource.isFirstLaunch()).thenAnswer((_) async => false);
    when(() => mockLocalDataSource.getToken()).thenAnswer((_) async => null);
    // act
    final result = await repository.getAppStatus();
    // assert
    expect(result, AppStatus.unauthenticated);
  });
}
