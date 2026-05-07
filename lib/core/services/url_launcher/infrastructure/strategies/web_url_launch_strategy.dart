import '../../xcore.dart';

/// Strategy for launching standard web links (http/https).
class WebUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    return uri.scheme == 'http' || uri.scheme == 'https';
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Defaults to opening in an external browser for better user experience
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
