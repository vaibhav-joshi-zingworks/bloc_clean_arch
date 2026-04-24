import '../../xcore.dart';

abstract class PermissionStrategy {
  Permission get permission;
  String get permissionMessage;

  Future<void> requestPermission(bool showSettingsDialog);
}
