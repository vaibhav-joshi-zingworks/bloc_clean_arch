/// Repository interface for persisting notification-related metadata.
/// 
/// Primarily used by the rate-limiting logic to track when notifications were last sent.
abstract class NotificationRepository {
  /// Retrieves the timestamp (in milliseconds) of the last sent notification for a specific channel.
  Future<int?> getLastSent(String channelKey);
  
  /// Persists the [timestamp] of the last sent notification for a specific channel.
  Future<void> setLastSent(String channelKey, int timestamp);
}
