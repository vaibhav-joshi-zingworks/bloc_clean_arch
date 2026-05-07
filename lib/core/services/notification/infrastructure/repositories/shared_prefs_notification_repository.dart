import '/core.dart';

/// Implementation of [NotificationRepository] using [SharedPreferences].
/// 
/// Stores notification metadata (like last sent timestamps) locally on the device.
class SharedPrefsNotificationRepository implements NotificationRepository {
  @override
  Future<int?> getLastSent(String channelKey) async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the timestamp for the specific notification channel
    return prefs.getInt('notif_$channelKey');
  }

  @override
  Future<void> setLastSent(String channelKey, int timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    // Persist the timestamp for the specific notification channel
    await prefs.setInt('notif_$channelKey', timestamp);
  }
}
