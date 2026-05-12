import 'package:bloc_clean_arch/features/auth/data/datasources/auth_remote_data_source_impl.dart';
import 'package:bloc_clean_arch/features/auth/data/dto/login_response_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:bloc_clean_arch/core.dart';

class MockBaseApiService extends Mock implements BaseApiService {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = AuthRemoteDataSourceImpl(MockBaseApiService());
  });

  group('AuthRemoteDataSourceImpl', () {
    test('login should return LoginResponseDto when credentials are correct', () async {
      final result = await dataSource.login(email: 'test', password: 'test');

      expect(result, isA<LoginResponseDto>());
      expect(result.user.id, 1);
      expect(result.user.name, 'Test');
      expect(result.accessToken, 'mock-access-token');
    });

    test('login should throw Exception when credentials are incorrect', () async {
      expect(
        () => dataSource.login(email: 'wrong', password: 'wrong'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
