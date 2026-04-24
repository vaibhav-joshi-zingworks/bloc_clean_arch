import '../../xcore.dart';

abstract class UrlLauncherService {
  Future<bool> launch(String url, {UrlType type = UrlType.web, LaunchMode? mode});
}
