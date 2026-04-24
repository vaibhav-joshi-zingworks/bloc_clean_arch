import '/core.dart';

abstract class NotificationStrategy {
  Future<void> initialize();

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

  Future<void> scheduleExact({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? route,
  });

  Future<void> showProgress({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required double progress,
  });

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

  Future<void> cancel(int id);
}
