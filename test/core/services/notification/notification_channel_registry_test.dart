import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationChannelRegistry extends Mock implements NotificationChannelRegistry {}

void main() {
  group('NotificationChannelRegistry', () {
    test('can be mocked', () {
      final registry = MockNotificationChannelRegistry();
      expect(registry, isA<NotificationChannelRegistry>());
    });
  });
}
