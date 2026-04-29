import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRateLimitStrategy extends Mock implements NotificationRateLimitStrategy {}

void main() {
  group('NotificationRateLimitStrategy', () {
    test('can be mocked', () {
      final strategy = MockNotificationRateLimitStrategy();
      expect(strategy, isA<NotificationRateLimitStrategy>());
    });
  });
}
