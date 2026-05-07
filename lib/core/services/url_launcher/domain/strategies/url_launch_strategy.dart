
import '../../xcore.dart';

/// Strategy interface for launching external URLs based on their [Uri] scheme.
abstract class UrlLaunchStrategy {
  /// Returns true if this strategy is capable of handling the given [uri].
  bool supports(Uri uri);

  /// Performs the actual launch operation for the [uri].
  Future<bool> launch(Uri uri, {LaunchMode? mode});
}
