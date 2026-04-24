import '../xcore.dart';

class NotificationStrategyFactory {
  NotificationStrategyFactory._();

  static NotificationStrategy create({
    NotificationRepository? repository,
    NotificationRateLimitStrategy? rateLimitStrategy,
    NotificationChannelRegistry? channelRegistry,
    AwesomeNotificationsAdapter? adapter,
  }) {
    final NotificationRepository repo = repository ?? SharedPrefsNotificationRepository();

    final NotificationRateLimitStrategy rateLimiter = rateLimitStrategy ?? LocalNotificationRateLimitStrategy(repository: repo);

    final NotificationChannelRegistry registry = channelRegistry ?? DefaultNotificationChannelRegistry();

    final AwesomeNotificationsAdapter notifAdapter = adapter ?? AwesomeNotificationsAdapter();

    return AwesomeNotificationStrategy(rateLimitStrategy: rateLimiter, adapter: notifAdapter, channelRegistry: registry);
  }
}
