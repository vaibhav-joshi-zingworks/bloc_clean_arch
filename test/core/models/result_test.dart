import 'package:bloc_clean_arch/core/models/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Result', () {
    test('should hold data and message', () {
      const result = Result<String>(data: 'test', message: 'success');
      expect(result.data, 'test');
      expect(result.message, 'success');
    });

    test('should work with null values', () {
      const result = Result<String>();
      expect(result.data, isNull);
      expect(result.message, isNull);
    });
  });
}
