import '/core.dart';

/// Domain model representing the configuration of a notification channel.
class NotificationChannelConfig {
  /// Unique identifier for the channel.
  final String key;
  
  /// Human-readable name displayed in system settings.
  final String name;
  
  /// Detailed explanation of the channel's purpose.
  final String description;
  
  /// Priority of notifications in this channel (High/Low/Default).
  final NotificationImportance importance;
  
  /// Required hours between notifications on this channel to prevent spam.
  final int cooldownHours;

  const NotificationChannelConfig({
    required this.key,
    required this.name,
    required this.description,
    required this.importance,
    this.cooldownHours = 0,
  });
}
