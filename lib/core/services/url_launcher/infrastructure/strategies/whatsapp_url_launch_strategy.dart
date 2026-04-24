import '../../xcore.dart';

class WhatsAppUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) {
    return uri.host.contains('wa.me');
  }

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
