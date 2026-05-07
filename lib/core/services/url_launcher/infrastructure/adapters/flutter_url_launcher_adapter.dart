import '../../xcore.dart';

/// Low-level adapter for the [url_launcher] plugin.
/// 
/// It encapsulates the plugin calls to ensure the rest of the app is not 
/// directly dependent on [url_launcher] and to facilitate testing.
class FlutterUrlLauncherAdapter {
  const FlutterUrlLauncherAdapter();

  /// Checks if the device has an app that can handle the given [uri], 
  /// and then attempts to launch it.
  Future<bool> launch(Uri uri) async {
    if (!await canLaunchUrl(uri)) {
      return false;
    }

    // Default to launching in an external application (Browser, Dialpad, etc.)
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
