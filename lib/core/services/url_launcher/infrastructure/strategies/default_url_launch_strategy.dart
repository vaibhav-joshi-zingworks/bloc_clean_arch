import '../../xcore.dart';

class DefaultUrlLaunchStrategy implements UrlLaunchStrategy {
  @override
  bool supports(Uri uri) => true;

  @override
  Future<bool> launch(Uri uri, {LaunchMode? mode}) async {
    return launchUrl(uri, mode: mode ?? LaunchMode.externalApplication);
  }
}
