import 'package:bloc_clean_arch/core/models/result_message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ResultMessage', () {
    test('fromJson should parse message correctly', () {
      final json = {'message': 'Hello'};
      final result = ResultMessage.fromJson(json);
      expect(result.message, 'Hello');
    });

    test('toJson should return correct map', () {
      const result = ResultMessage(message: 'World');
      final json = result.toJson();
      expect(json['message'], 'World');
    });
  });
}
