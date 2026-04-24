import '/core.dart';
import '../../../analytics/xcore.dart';

class AwesomeNotificationEventHandler {
  @pragma("vm:entry-point")
  static Future<void> onCreated(ReceivedNotification notification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDisplayed(ReceivedNotification notification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismiss(ReceivedAction action) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceived(ReceivedAction action) async {
    final payload = action.payload;

    // Inline reply
    if (action.buttonKeyPressed == 'REPLY' && action.buttonKeyInput.isNotEmpty) {
      final replyText = action.buttonKeyInput;
      logInfo("💬 Reply to messageId=${payload?["messageId"]}: $replyText");
      // TODO: send reply to backend using payload["chatId"] & payload["messageId"]
    }

    // Mark as read
    if (action.buttonKeyPressed == 'MARK_READ') {
      logInfo("✔️ Mark Read messageId=${payload?["messageId"]}");
      // TODO: mark message read in backend
    }

    // Default navigation
    if (payload != null && payload.containsKey("route")) {
      final context = NavigationService.context;
      if (context != null) context.go(payload["route"]!);
    }
  }
}
