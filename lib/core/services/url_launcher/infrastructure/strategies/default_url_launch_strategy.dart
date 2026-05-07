import '../../xcore.dart';

/// A fallback strategy that attempts to launch any URL using the system's default handler.
class DefaultUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => true;

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) async {
    // Attempt to open the URL in an external application
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
