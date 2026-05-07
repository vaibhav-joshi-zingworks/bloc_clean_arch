import '../../xcore.dart';

/// Strategy for launching the device's default SMS application.
class SmsUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'sms';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Opens the messaging app with the recipient number pre-filled
    return launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
  }
}
