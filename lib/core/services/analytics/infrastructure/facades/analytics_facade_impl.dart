import '../../../../../core.dart';

/// Concrete implementation of [AnalyticsFacade].
/// 
/// It uses the Strategy pattern to delegate analytics operations to a specific
/// [AnalyticsStrategy] implementation.
class AnalyticsFacadeImpl implements AnalyticsFacade{
  /// The active strategy used for logging analytics.
  final AnalyticsStrategy strategy;

  AnalyticsFacadeImpl(this.strategy);

  @override
  Future<void> init({bool isEnabled = true}) {
    return strategy.init(isEnabled: isEnabled);
  }

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) {
    return strategy.logEvent(name, parameters: parameters);
  }

  @override
  Future<void> setUserId(String userId) {
    return strategy.setUserId(userId);
  }

  @override
  Future<void> setUserProperty(String name, String value) {
    return strategy.setUserProperty(name, value);
  }

  @override
  NavigatorObserver? get observer => strategy.observer;

}
