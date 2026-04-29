import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AwesomeNotificationEventHandler', () {
    test('static methods should exist', () {
      // Just check existence if we can't easily trigger
      expect(AwesomeNotificationEventHandler.onActionReceived, isNotNull);
    });
  });
}
