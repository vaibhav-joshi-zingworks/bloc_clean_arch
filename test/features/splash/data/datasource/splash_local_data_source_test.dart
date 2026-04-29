import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/splash/data/datasource/splash_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageFacade extends Mock implements StorageFacade {}

void main() {
  late SplashLocalDataSource dataSource;
  late MockStorageFacade mockStorage;

  setUp(() {
    mockStorage = MockStorageFacade();
    dataSource = SplashLocalDataSource(mockStorage);
  });

  group('SplashLocalDataSource', () {
    test('getToken should call storage.read with auth_token', () async {
      when(() => mockStorage.read('auth_token')).thenAnswer((_) async => 'token');
      final result = await dataSource.getToken();
      expect(result, 'token');
      verify(() => mockStorage.read('auth_token')).called(1);
    });

    test('isFirstLaunch should return true if first_launch is null', () async {
      when(() => mockStorage.read('first_launch')).thenAnswer((_) async => null);
      final result = await dataSource.isFirstLaunch();
      expect(result, true);
    });
  });
}
