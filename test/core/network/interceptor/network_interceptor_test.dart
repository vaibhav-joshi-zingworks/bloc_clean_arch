import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkMonitorService extends Mock implements NetworkMonitorService {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class FakeDioException extends Fake implements DioException {}

void main() {
  late NetworkInterceptor interceptor;
  late MockNetworkMonitorService mockService;
  late MockRequestInterceptorHandler mockHandler;

  setUpAll(() {
    registerFallbackValue(FakeDioException()); // 🔥 REQUIRED
  });

  setUp(() {
    mockService = MockNetworkMonitorService();
    mockHandler = MockRequestInterceptorHandler();
    interceptor = NetworkInterceptor(mockService);
  });

  test('should call handler.reject when disconnected', () async {
    final options = RequestOptions(path: '/test');

    when(() => mockService.isConnected())
        .thenAnswer((_) async => false);

    interceptor.onRequest(options, mockHandler);

    await Future.delayed(Duration.zero);

    verify(() => mockHandler.reject(any())).called(1);
  });
}
