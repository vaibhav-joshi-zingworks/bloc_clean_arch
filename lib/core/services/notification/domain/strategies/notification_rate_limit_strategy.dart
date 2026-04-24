abstract class NotificationRateLimitStrategy {
  Future<bool> canSend(String channelKey);
  Future<void> markSent(String channelKey);
}
