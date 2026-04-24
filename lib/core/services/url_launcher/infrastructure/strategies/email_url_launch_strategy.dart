import '../../xcore.dart';

class MailtoUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => uri.scheme == 'mailto';

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) {
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
