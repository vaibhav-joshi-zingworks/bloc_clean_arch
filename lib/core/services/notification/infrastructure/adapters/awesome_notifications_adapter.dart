import '/core.dart';

class AwesomeNotificationsAdapter {
  final AwesomeNotifications _plugin = AwesomeNotifications();

  Future<void> initialize(List<NotificationChannel> channels) {
    return _plugin.initialize(null, channels);
  }

  Future<void> create(NotificationContent content, {List<NotificationActionButton>? actionButtons, NotificationSchedule? schedule}) {
    return _plugin.createNotification(content: content, schedule: schedule, actionButtons: actionButtons);
  }

  Future<void> cancel(int id) => _plugin.cancel(id);

  Future<bool> isAllowed() => _plugin.isNotificationAllowed();

  Future<void> requestPermission() => _plugin.requestPermissionToSendNotifications();

  Future<String> getTimeZone() => _plugin.getLocalTimeZoneIdentifier();

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
