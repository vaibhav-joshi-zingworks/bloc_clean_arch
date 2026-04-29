import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageFacade extends Mock implements StorageFacade {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}

void main() {
  late AuthInterceptor interceptor;
  late MockStorageFacade mockStorage;
  late MockRequestInterceptorHandler mockHandler;

  setUp(() {
    mockStorage = MockStorageFacade();
    mockHandler = MockRequestInterceptorHandler();
    interceptor = AuthInterceptor(mockStorage);
  });

  group('AuthInterceptor', () {
    test('should add Authorization header when token exists', () async {
      // arrange
      final options = RequestOptions(path: '/test');
      when(() => mockStorage.read(Flags.token)).thenAnswer((_) async => 'test-token');
      when(() => mockStorage.read(Flags.refreshToken)).thenAnswer((_) async => null);

      // act
      await interceptor.onRequest(options, mockHandler);

      // assert
      expect(options.headers[HeaderKey.authorization], 'Bearer test-token');
      verify(() => mockHandler.next(options)).called(1);
    });

    test('should not add Authorization header when token is null', () async {
      // arrange
      final options = RequestOptions(path: '/test');
      when(() => mockStorage.read(any())).thenAnswer((_) async => null);

      // act
      await interceptor.onRequest(options, mockHandler);

      // assert
      expect(options.headers.containsKey(HeaderKey.authorization), false);
      verify(() => mockHandler.next(options)).called(1);
    });
  });
}
