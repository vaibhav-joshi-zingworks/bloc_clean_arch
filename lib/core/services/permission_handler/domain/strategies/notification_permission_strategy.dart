import '../../xcore.dart';

class NotificationPermissionStrategy implements PermissionStrategy {
  final PermissionDialogHandler _dialogHandler;

  NotificationPermissionStrategy(this._dialogHandler);

  @override
  Permission get permission => Permission.notification;

  @override
  String get permissionMessage =>
      "bloc_clean_arch would like to send you notifications about loan status, payment reminders, and important updates.";

  @override
  Future<void> requestPermission(bool showSettingsDialog) async {
    final status = await permission.status;
    if (status.isGranted) return;

    final result = await permission.request();

    if (result.isPermanentlyDenied && showSettingsDialog) {
      await _dialogHandler.showOpenSettingsDialog(permission, permissionMessage);
    }
  }
}
