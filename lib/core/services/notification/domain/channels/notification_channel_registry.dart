import '/core.dart';

/// Interface for registering and retrieving system-level notification channels.
abstract class NotificationChannelRegistry {
  /// Returns the full list of [NotificationChannel]s that need to be created on the device.
  List<NotificationChannel> getChannels();
}
