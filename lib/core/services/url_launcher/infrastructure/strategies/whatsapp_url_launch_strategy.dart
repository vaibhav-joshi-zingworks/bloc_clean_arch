import '../../xcore.dart';

/// Strategy for launching the WhatsApp application via deep links.
class WhatsAppUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    // Detects the standard WhatsApp 'wa.me' domain
    return uri.host.contains('wa.me');
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    // Opens the WhatsApp app directly if installed, or the web version if not
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
