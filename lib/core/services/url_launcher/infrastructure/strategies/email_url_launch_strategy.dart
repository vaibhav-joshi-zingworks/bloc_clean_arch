import '../../xcore.dart';

/// Strategy for launching the device's default email client.
class MailtoUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'mailto';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Standard behavior for mailto links is to open the system mail app
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
