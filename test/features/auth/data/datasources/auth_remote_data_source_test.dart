import 'package:bloc_clean_arch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthRemoteDataSourceImpl dataSource;

  setUp(() {
    dataSource = AuthRemoteDataSourceImpl();
  });

  group('AuthRemoteDataSourceImpl', () {
    test('login should return UserModel when credentials are correct', () async {
      final result = await dataSource.login(email: 'test', password: 'test');
      expect(result.id, 1);
      expect(result.name, 'Test');
    });

    test('login should throw Exception when credentials are incorrect', () async {
      expect(
        () => dataSource.login(email: 'wrong', password: 'wrong'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
