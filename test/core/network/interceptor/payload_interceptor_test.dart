import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/encryption/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEncryptionManager extends Mock implements EncryptionManager {}
class MockRequestInterceptorHandler extends Mock implements RequestInterceptorHandler {}
class MockResponseInterceptorHandler extends Mock implements ResponseInterceptorHandler {}

void main() {
  late PayloadInterceptor interceptor;
  late MockEncryptionManager mockEncryptionManager;
  late MockRequestInterceptorHandler mockReqHandler;
  late MockResponseInterceptorHandler mockResHandler;

  setUp(() {
    mockEncryptionManager = MockEncryptionManager();
    mockReqHandler = MockRequestInterceptorHandler();
    mockResHandler = MockResponseInterceptorHandler();
    interceptor = PayloadInterceptor(mockEncryptionManager);
  });

  group('PayloadInterceptor', () {
    test('should encrypt request data for POST method', () async {
      final data = {'key': 'value'};
      final options = RequestOptions(
        path: '/test',
        method: 'POST',
        data: data,
      );
      
      when(() => mockEncryptionManager.encrypt(any())).thenReturn('encrypted_data');

      interceptor.onRequest(options, mockReqHandler);

      expect(options.data, 'encrypted_data');
      verify(() => mockEncryptionManager.encrypt(jsonEncode(data))).called(1);
      verify(() => mockReqHandler.next(options)).called(1);
    });

    test('should decrypt response data when it contains "data" key', () async {
      final responseData = {'status': true, 'data': 'encrypted_response'};
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        data: responseData,
      );
      
      when(() => mockEncryptionManager.decrypt(any())).thenReturn(jsonEncode({'result': 'success'}));

      interceptor.onResponse(response, mockResHandler);

      expect(response.data?['data'], {'result': 'success'});
      verify(() => mockEncryptionManager.decrypt('encrypted_response')).called(1);
      verify(() => mockResHandler.next(response)).called(1);
    });
  });
}
