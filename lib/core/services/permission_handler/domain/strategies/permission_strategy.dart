import '../../xcore.dart';

/// Abstract base for implementing specialized logic for individual system permissions.
abstract class PermissionStrategy {
  /// The underlying [Permission] type from the plugin.
  Permission get permission;
  
  /// The user-facing explanation for why this permission is requested.
  String get permissionMessage;

  /// Executes the permission request flow.
  /// 
  /// If [showSettingsDialog] is true, it displays a helper dialog if the 
  /// permission is permanently denied.
  Future<void> requestPermission(bool showSettingsDialog);
}
