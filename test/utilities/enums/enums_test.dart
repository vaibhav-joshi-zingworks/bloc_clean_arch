import 'package:bloc_clean_arch/utilities/enums/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MessageType', () {
    test('should have expected values', () {
      expect(MessageType.values, contains(MessageType.success));
      expect(MessageType.values, contains(MessageType.general));
      expect(MessageType.values, contains(MessageType.error));
      expect(MessageType.values, contains(MessageType.info));
      expect(MessageType.values, contains(MessageType.warning));
    });
  });
}
