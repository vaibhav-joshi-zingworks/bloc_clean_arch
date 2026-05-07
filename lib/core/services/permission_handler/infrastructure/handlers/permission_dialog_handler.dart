
import '../../../../../core.dart';

/// Service for displaying UI dialogs when system permissions are denied or restricted.
class PermissionDialogHandler {
  /// Tracks if a dialog is currently active to prevent duplicate popups.
  bool _dialogShowing = false;

  /// Shows an adaptive alert dialog explaining why a [permission] is needed 
  /// and provides a direct shortcut to the app settings.
  Future<void> showOpenSettingsDialog(Permission permission, String message) async {
    if (_dialogShowing) return;

    // Use the global navigator key to find the current context
    final context = Global.navigatorKey.currentContext;
    if (context == null || !context.mounted) return;

    _dialogShowing = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text('Permission Required'),
          content: Text(message),
          actions: [
            TextButton(child: const Text('Cancel'), onPressed: () => Navigator.pop(context)),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () async {
                Navigator.pop(context);
                // Slight delay to ensure the dialog is fully dismissed before app switches focus
                await Future.delayed(const Duration(milliseconds: 200));
                await openAppSettings();
              },
            ),
          ],
        );
      },
    );

    _dialogShowing = false;
  }
}
