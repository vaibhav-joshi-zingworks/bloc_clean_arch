import '/core.dart';

/// Low-level adapter for the [AwesomeNotifications] plugin.
/// 
/// This class wraps the plugin's static and instance methods to make them 
/// more easily testable and decoupled from the rest of the application.
class AwesomeNotificationsAdapter {
  final AwesomeNotifications _plugin = AwesomeNotifications();

  /// Initializes the plugin with the provided list of [NotificationChannel]s.
  Future<void> initialize(List<NotificationChannel> channels) {
    return _plugin.initialize(null, channels);
  }

  /// Creates and displays a notification.
  Future<void> create(
    NotificationContent content, {
    List<NotificationActionButton>? actionButtons, 
    NotificationSchedule? schedule
  }) {
    return _plugin.createNotification(
      content: content, 
      schedule: schedule, 
      actionButtons: actionButtons
    );
  }

  /// Cancels an active notification by its [id].
  Future<void> cancel(int id) => _plugin.cancel(id);

  /// Checks if the user has granted permission to send notifications.
  Future<bool> isAllowed() => _plugin.isNotificationAllowed();

  /// Requests the user for notification permissions.
  Future<void> requestPermission() => _plugin.requestPermissionToSendNotifications();

  /// Returns the current local time zone identifier.
  Future<String> getTimeZone() => _plugin.getLocalTimeZoneIdentifier();

  /// Sets global static listeners for various notification lifecycle events.
  void setListeners({
    required ActionHandler onAction,
    required NotificationHandler onCreated,
    required NotificationHandler onDisplayed,
    required ActionHandler onDismiss,
  }) {
    _plugin.setListeners(
      onActionReceivedMethod: onAction,
      onNotificationCreatedMethod: onCreated,
      onNotificationDisplayedMethod: onDisplayed,
      onDismissActionReceivedMethod: onDismiss,
    );
  }
}
