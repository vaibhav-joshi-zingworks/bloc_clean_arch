
import '../../xcore.dart';

/// Centralized configuration for URL launching behavior.
class LaunchModeConfig {
  /// The default [LaunchMode] used when none is explicitly provided.
  /// 
  /// Set to [LaunchMode.externalApplication] to prefer opening links in 
  /// dedicated system apps (Browser, Maps, etc.) rather than in-app webviews.
  static LaunchMode get defaultMode => LaunchMode.externalApplication;
}
