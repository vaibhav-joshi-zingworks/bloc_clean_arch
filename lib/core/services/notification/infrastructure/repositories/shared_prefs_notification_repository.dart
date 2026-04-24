import '/core.dart';

class SharedPrefsNotificationRepository implements NotificationRepository {
  @override
  Future<int?> getLastSent(String channelKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('notif_$channelKey');
  }

  @override
  Future<void> setLastSent(String channelKey, int timestamp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notif_$channelKey', timestamp);
  }
}
