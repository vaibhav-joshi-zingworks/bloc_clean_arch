import '../xcore.dart';

/// Factory class for creating and configuring [NotificationStrategy] instances.
class NotificationStrategyFactory {
  NotificationStrategyFactory._();

  /// Creates a notification strategy by assembling all required components.
  /// 
  /// Uses [AwesomeNotificationStrategy] as the default implementation.
  static NotificationStrategy create({
    NotificationRepository? repository,
    NotificationRateLimitStrategy? rateLimitStrategy,
    NotificationChannelRegistry? channelRegistry,
    AwesomeNotificationsAdapter? adapter,
  }) {
    // Fallback to default implementations if specialized ones aren't provided
    final NotificationRepository repo = repository ?? SharedPrefsNotificationRepository();

    final NotificationRateLimitStrategy rateLimiter = rateLimitStrategy ?? LocalNotificationRateLimitStrategy(repository: repo);

    final NotificationChannelRegistry registry = channelRegistry ?? DefaultNotificationChannelRegistry();

    final AwesomeNotificationsAdapter notifAdapter = adapter ?? AwesomeNotificationsAdapter();

    return AwesomeNotificationStrategy(rateLimitStrategy: rateLimiter, adapter: notifAdapter, channelRegistry: registry);
  }
}
