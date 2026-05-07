import '../../../../../core.dart';

/// Abstract contract for providing analytics services.
/// 
/// This facade decouples the application from specific analytics providers 
/// (like Firebase, Mixpanel, etc.), allowing them to be easily swapped.
abstract class AnalyticsFacade {
  /// Initializes the analytics service.
  Future<void> init({bool isEnabled = true});

  /// Logs a custom event with the given [name] and optional [parameters].
  Future<void> logEvent(String name, {Map<String, Object>? parameters});

  /// Associates subsequent events with a specific [userId].
  Future<void> setUserId(String userId);

  /// Sets a persistent user-level [name] property with a specific [value].
  Future<void> setUserProperty(String name, String value);

  /// Returns a [NavigatorObserver] for automatic screen tracking if supported by the provider.
  NavigatorObserver? get observer;
}
