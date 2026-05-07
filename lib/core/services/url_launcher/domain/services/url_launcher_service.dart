import '../../xcore.dart';

/// Abstract service for opening external URLs (Web, Phone, Email, SMS).
abstract class UrlLauncherService {
  /// Attempts to launch the given [url].
  /// 
  /// The [type] parameter helps specify the URL protocol if not explicitly in the string.
  /// [mode] can be used to control how the URL is opened (In-app vs Browser).
  Future<bool> launch(String url, {UrlType type = UrlType.web, LaunchMode? mode});
}
