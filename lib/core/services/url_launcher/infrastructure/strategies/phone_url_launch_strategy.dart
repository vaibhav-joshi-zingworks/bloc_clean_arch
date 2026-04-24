import '../../xcore.dart';

class TelUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'tel';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.platformDefault);
  }
}
