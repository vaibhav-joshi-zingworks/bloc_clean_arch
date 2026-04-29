import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkMonitorService extends Mock implements NetworkMonitorService {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}

void main() {
  late NetworkInterceptor interceptor;
  late MockNetworkMonitorService mockService;
  late MockRequestInterceptorHandler mockHandler;

  setUp(() {
    mockService = MockNetworkMonitorService();
    mockHandler = MockRequestInterceptorHandler();
    interceptor = NetworkInterceptor(mockService);
  });

  group('NetworkInterceptor', () {
    test('should call handler.next when connected', () async {
      final options = RequestOptions(path: '/test');
      when(() => mockService.isConnected()).thenAnswer((_) async => true);

      await interceptor.onRequest(options, mockHandler);

      verify(() => mockHandler.next(options)).called(1);
    });

    test('should call handler.reject when disconnected', () async {
      final options = RequestOptions(path: '/test');
      when(() => mockService.isConnected()).thenAnswer((_) async => false);

      await interceptor.onRequest(options, mockHandler);

      verify(() => mockHandler.reject(any())).called(1);
    });
  });
}
