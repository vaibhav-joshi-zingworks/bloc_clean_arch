import '../../../analytics/xcore.dart';
import '../../xcore.dart';

class LocalNotificationRateLimitStrategy implements NotificationRateLimitStrategy {
  final NotificationRepository repository;

  LocalNotificationRateLimitStrategy({required this.repository});

  @override
  Future<bool> canSend(String channelKey) async {
    final lastSent = await repository.getLastSent(channelKey);

    if (lastSent == null) return true;

    final cooldown = NotificationChannels.cooldownForKey(channelKey);

    if (cooldown == 0) return true;

    final lastTime = DateTime.fromMillisecondsSinceEpoch(lastSent);
    bool canSend = DateTime.now().difference(lastTime).inHours >= cooldown;
    logInfo("LocalNotificationRateLimitStrategy - canSend: $channelKey: $canSend");
    return canSend;
  }

  @override
  Future<void> markSent(String channelKey) async {
    logInfo("LocalNotificationRateLimitStrategy - setLastSent: $channelKey");
    await repository.setLastSent(channelKey, DateTime.now().millisecondsSinceEpoch);
  }
}
