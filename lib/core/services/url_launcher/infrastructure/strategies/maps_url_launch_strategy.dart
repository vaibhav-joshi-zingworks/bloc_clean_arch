import '../../xcore.dart';

/// Strategy for launching navigation and map URLs (Google Maps, etc.).
class MapsUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    // Specifically checks for Google Maps domains and paths
    return uri.host.contains('google.com') && uri.path.contains('maps');
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Launch in an external maps application for native navigation features
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
