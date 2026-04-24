import '/core.dart';

class NotificationChannels {
  static const Map<NotificationChannelType, NotificationChannelConfig> channels = {
    NotificationChannelType.general: NotificationChannelConfig(
      key: 'general',
      name: 'General',
      description: 'General notifications',
      importance: NotificationImportance.High,
      cooldownHours: 0,
    ),

    NotificationChannelType.marketing: NotificationChannelConfig(
      key: 'marketing',
      name: 'Marketing',
      description: 'Promotional notifications',
      importance: NotificationImportance.Default,
      cooldownHours: 4,
    ),

    NotificationChannelType.transactions: NotificationChannelConfig(
      key: 'transactions',
      name: 'Transactions',
      description: 'Transaction-related notifications',
      importance: NotificationImportance.High,
      cooldownHours: 0,
    ),

    NotificationChannelType.reminders: NotificationChannelConfig(
      key: 'reminders',
      name: 'Reminders',
      description: 'Reminder notifications',
      importance: NotificationImportance.Default,
      cooldownHours: 1,
    ),

    NotificationChannelType.progress: NotificationChannelConfig(
      key: 'progress',
      name: 'Progress',
      description: 'Progress notifications',
      importance: NotificationImportance.Low,
      cooldownHours: 0,
    ),

    NotificationChannelType.chat: NotificationChannelConfig(
      key: 'chat',
      name: 'Chat',
      description: 'Single chat messages',
      importance: NotificationImportance.High,
      cooldownHours: 0,
    ),

    NotificationChannelType.groupChat: NotificationChannelConfig(
      key: 'group_chat',
      name: 'Group Chat',
      description: 'Group chat messages',
      importance: NotificationImportance.High,
      cooldownHours: 0,
    ),
  };

  static List<NotificationChannel> toAwesomeChannels() {
    return channels.values.map((config) {
      return NotificationChannel(
        channelKey: config.key,
        channelName: config.name,
        channelDescription: config.description,
        importance: config.importance,
      );
    }).toList();
  }

  static String key(NotificationChannelType type) {
    return channels[type]!.key;
  }

  static int cooldownForKey(String channelKey) {
    final channel = channels.values.firstWhere(
      (c) => c.key == channelKey,
      orElse: () => NotificationChannelConfig(
        key: channelKey,
        cooldownHours: 0,
        name: channelKey,
        description: channelKey,
        importance: NotificationImportance.Default,
      ),
    );
    return channel.cooldownHours;
  }
}
