import 'package:go_router/go_router.dart';

import '/core.dart';

/// Static handler for reacting to global notification events.
/// 
/// Methods are marked with `@pragma("vm:entry-point")` to ensure they are 
/// accessible by the native background service (Isolate).
class AwesomeNotificationEventHandler {
  
  /// Triggered when a notification is first created.
  @pragma("vm:entry-point")
  static Future<void> onCreated(ReceivedNotification notification) async {}

  /// Triggered when a notification is displayed on the user's screen.
  @pragma("vm:entry-point")
  static Future<void> onDisplayed(ReceivedNotification notification) async {}

  /// Triggered when the user dismisses a notification.
  @pragma("vm:entry-point")
  static Future<void> onDismiss(ReceivedAction action) async {}

  /// Main handler for user interactions with notifications (taps, button clicks).
  @pragma("vm:entry-point")
  static Future<void> onActionReceived(ReceivedAction action) async {
    final payload = action.payload;

    // Handle Inline Replies (Android only)
    if (action.buttonKeyPressed == 'REPLY' && action.buttonKeyInput.isNotEmpty) {
      final replyText = action.buttonKeyInput;
      logInfo("💬 Reply to messageId=${payload?["messageId"]}: $replyText");
      // TODO: Perform network call to send the reply text to the backend
    }

    // Handle Custom Action: 'Mark as Read'
    if (action.buttonKeyPressed == 'MARK_READ') {
      logInfo("✔️ Mark Read messageId=${payload?["messageId"]}");
      // TODO: Perform network call to update message status
    }

    // Handle Default Tap Action: Navigation
    // If a 'route' was passed in the notification payload, navigate to it.
    if (payload != null && payload.containsKey("route")) {
      sl<GoRouter>().go(payload["route"]!);
    }
  }
}
