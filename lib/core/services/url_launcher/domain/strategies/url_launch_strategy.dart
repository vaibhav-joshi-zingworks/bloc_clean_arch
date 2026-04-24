
import '../../xcore.dart';

abstract class UrlLaunchStrategy {
  bool supports(Uri uri);

  Future<bool> launch(Uri uri, {LaunchMode? mode});
}
