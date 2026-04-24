import '/core.dart';

class NotificationChannelConfig {
  final String key;
  final String name;
  final String description;
  final NotificationImportance importance;
  final int cooldownHours;

  const NotificationChannelConfig({
    required this.key,
    required this.name,
    required this.description,
    required this.importance,
    this.cooldownHours = 0,
  });
}
