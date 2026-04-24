import '../../xcore.dart';

class CameraPermissionStrategy implements PermissionStrategy {
  final PermissionDialogHandler _dialogHandler;

  CameraPermissionStrategy(this._dialogHandler);

  @override
  Permission get permission => Permission.camera;

  @override
  String get permissionMessage => "bloc_clean_arch requires access to your camera to take a selfie for identity verification.";

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
