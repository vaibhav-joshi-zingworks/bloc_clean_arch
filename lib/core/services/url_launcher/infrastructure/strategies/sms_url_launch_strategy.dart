import '../../xcore.dart';

class SmsUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'sms';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
  }
}
