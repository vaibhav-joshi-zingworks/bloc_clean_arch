import '../../../../../core.dart';

/// Strategy interface for implementing various analytics providers.
/// 
/// This follows the Strategy Pattern to allow different analytics implementations
/// (like Firebase or Mixpanel) to be swapped out easily.
abstract class AnalyticsStrategy {
  /// Initializes the specific analytics provider.
  Future<void> init({bool isEnabled = true});
  
  /// Logs an event with the given name and parameters.
  Future<void> logEvent(String name, {Map<String, Object>? parameters});

  /// Sets the user ID for identifying users in analytics.
  Future<void> setUserId(String userId);

  /// Sets a custom user property.
  Future<void> setUserProperty(String name, String value);
  
  /// Returns the [NavigatorObserver] for the specific analytics provider.
  NavigatorObserver? get observer;
}
