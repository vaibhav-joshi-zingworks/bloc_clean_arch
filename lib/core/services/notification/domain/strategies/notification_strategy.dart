import '/core.dart';

/// Abstract contract for local notification engines.
/// 
/// This allows the app to support complex notification types (simple, scheduled, 
/// progress bars, and chat messages) using different backends like AwesomeNotifications.
abstract class NotificationStrategy {
  /// Sets up notification channels and permissions.
  Future<void> initialize();

  /// Displays an immediate local notification.
  Future<void> show({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    String? route,
    String? groupKey,
    String? bigPicture,
    NotificationLayout? layout,
  });

  /// Schedules a notification to be displayed at a specific [scheduledDate].
  Future<void> scheduleExact({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? route,
  });

  /// Displays a notification with a progress bar (e.g. for downloads).
  Future<void> showProgress({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required double progress,
  });

  /// Displays a messaging-style notification with sender info.
  Future<void> showChatMessage({
    required int id,
    required String title,
    required String body,
    required ChatType chatType,
    required String senderId,
    required String senderName,
    required String chatId,
    required String messageId,
    String? senderAvatar,
    String? groupKey,
    String? route,
  });

  /// Removes a specific notification from the notification drawer.
  Future<void> cancel(int id);
}
