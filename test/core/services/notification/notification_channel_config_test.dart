import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationChannelConfig', () {
    test('should initialize correctly', () {
      const config = NotificationChannelConfig(
        key: 'key',
        name: 'name',
        description: 'desc',
        importance: NotificationImportance.High,
      );
      expect(config.key, 'key');
      expect(config.name, 'name');
    });
  });
}
