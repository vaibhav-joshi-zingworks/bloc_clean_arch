import '../../../analytics/xcore.dart';
import '../../xcore.dart';

/// Implementation of [NotificationRateLimitStrategy] using local persistence.
/// 
/// It enforces a "cooldown" period between notifications of the same channel 
/// to prevent overwhelming the user.
class LocalNotificationRateLimitStrategy implements NotificationRateLimitStrategy {
  final NotificationRepository repository;

  LocalNotificationRateLimitStrategy({required this.repository});

  @override
  Future<bool> canSend(String channelKey) async {
    // 1. Retrieve the last sent timestamp from local storage
    final lastSent = await repository.getLastSent(channelKey);

    if (lastSent == null) return true;

    // 2. Fetch the required cooldown duration (in hours) for this specific channel
    final cooldown = NotificationChannels.cooldownForKey(channelKey);

    // If cooldown is 0, we can always send
    if (cooldown == 0) return true;

    // 3. Calculate the time elapsed since the last notification
    final lastTime = DateTime.fromMillisecondsSinceEpoch(lastSent);
    bool canSend = DateTime.now().difference(lastTime).inHours >= cooldown;
    
    logInfo("LocalNotificationRateLimitStrategy - canSend check for $channelKey: $canSend");
    return canSend;
  }

  @override
  Future<void> markSent(String channelKey) async {
    logInfo("LocalNotificationRateLimitStrategy - updating last sent for $channelKey");
    // Persist the current timestamp as the new reference for rate limiting
    await repository.setLastSent(channelKey, DateTime.now().millisecondsSinceEpoch);
  }
}
