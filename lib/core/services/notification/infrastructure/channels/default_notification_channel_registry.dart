import '/core.dart';

class DefaultNotificationChannelRegistry implements NotificationChannelRegistry {
  @override
  List<NotificationChannel> getChannels() {
    return NotificationChannels.toAwesomeChannels();
  }
}
