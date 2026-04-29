import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationChannelType', () {
    test('should have expected values', () {
      expect(NotificationChannelType.values, contains(NotificationChannelType.general));
    });
  });
}
