import 'package:bloc_clean_arch/core/failure/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppException', () {
    test('toString returns correct format', () {
      final exception = AppException(404, 'Not Found');
      expect(exception.toString(), 'AppException(code: 404, message: Not Found)');
    });

    test('NoInternetError has correct code and message', () {
      final error = NoInternetError();
      expect(error.code, 503);
      expect(error.message, 'No internet connection');
    });

    test('UnauthorizedError defaults to 401', () {
      final error = UnauthorizedError();
      expect(error.code, 401);
    });
  });
}
