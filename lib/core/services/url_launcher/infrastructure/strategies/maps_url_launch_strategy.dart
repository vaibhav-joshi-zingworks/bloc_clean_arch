import '../../xcore.dart';

class MapsUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    return uri.host.contains('google.com') && uri.path.contains('maps');
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
