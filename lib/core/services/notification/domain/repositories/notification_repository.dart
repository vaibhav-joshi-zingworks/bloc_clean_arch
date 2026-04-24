abstract class NotificationRepository {
  Future<int?> getLastSent(String channelKey);
  Future<void> setLastSent(String channelKey, int timestamp);
}
