import '/core.dart';

/// Default implementation of [NotificationChannelRegistry].
/// 
/// It acts as a bridge to retrieve all predefined [NotificationChannel]s 
/// required by the system.
class DefaultNotificationChannelRegistry implements NotificationChannelRegistry {
  @override
  List<NotificationChannel> getChannels() {
    // Collect all channel definitions from the static constants
    return NotificationChannels.toAwesomeChannels();
  }
}
