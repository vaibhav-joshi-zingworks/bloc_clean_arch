import '../../xcore.dart';

/// Strategy for launching the device's telephone dialpad.
class TelUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'tel';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Opens the dialpad with the phone number pre-filled
    return launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
  }
}
