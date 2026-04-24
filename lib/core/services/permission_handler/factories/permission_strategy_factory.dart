import '../xcore.dart';

class PermissionStrategyFactory {
  final PermissionDialogHandler _dialogHandler;

  PermissionStrategyFactory(this._dialogHandler);

  PermissionStrategy? createStrategy(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return CameraPermissionStrategy(_dialogHandler);
      case Permission.notification:
        return NotificationPermissionStrategy(_dialogHandler);
      default:
        return null;
    }
  }
}
