import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationChannels', () {
    test('key should return correct string', () {
      expect(NotificationChannels.key(NotificationChannelType.general), 'general');
    });
  });
}
