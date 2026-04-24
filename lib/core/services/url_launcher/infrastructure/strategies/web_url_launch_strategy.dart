import '../../xcore.dart';

class WebUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
