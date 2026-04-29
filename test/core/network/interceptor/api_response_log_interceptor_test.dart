import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ApiResponseLogInterceptor should create an Interceptor', () {
    final interceptor = ApiResponseLogInterceptor();
    final result = interceptor.create();
    expect(result, isA<Interceptor>());
  });
}
