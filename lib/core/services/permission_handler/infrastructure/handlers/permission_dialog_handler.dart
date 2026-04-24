
import '../../../../../core.dart';

class PermissionDialogHandler {
  bool _dialogShowing = false;

  Future<void> showOpenSettingsDialog(Permission permission, String message) async {
    if (_dialogShowing) return;

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
