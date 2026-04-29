import 'package:bloc_clean_arch/core/services/notification/factories/notification_strategy_factory.dart';
import 'package:bloc_clean_arch/core/services/notification/infrastructure/strategies/awesome_notification_strategy.dart';
import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock implements NotificationRepository {}
class MockNotificationRateLimitStrategy extends Mock implements NotificationRateLimitStrategy {}
class MockNotificationChannelRegistry extends Mock implements NotificationChannelRegistry {}
class MockAwesomeNotificationsAdapter extends Mock implements AwesomeNotificationsAdapter {}

void main() {
  group('NotificationStrategyFactory', () {
    test('create returns an AwesomeNotificationStrategy', () {
      final strategy = NotificationStrategyFactory.create(
        repository: MockNotificationRepository(),
        rateLimitStrategy: MockNotificationRateLimitStrategy(),
        channelRegistry: MockNotificationChannelRegistry(),
        adapter: MockAwesomeNotificationsAdapter(),
      );

      expect(strategy, isA<AwesomeNotificationStrategy>());
    });
  });
}
