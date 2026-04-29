import 'package:bloc_clean_arch/app/providers/app_message.dart';
import 'package:bloc_clean_arch/utilities/enums/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppMessage', () {
    test('should initialize with correct values', () {
      final message = AppMessage(message: 'Test message', type: MessageType.info);
      
      expect(message.message, 'Test message');
      expect(message.type, MessageType.info);
    });
  });
}
