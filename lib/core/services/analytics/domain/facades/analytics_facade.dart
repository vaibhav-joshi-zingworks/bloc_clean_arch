import '../../../../../core.dart';

abstract class AnalyticsFacade {
  Future<void> init({bool isEnabled = true});
  Future<void> logEvent(String name, {Map<String, Object>? parameters});

  Future<void> setUserId(String userId);

  Future<void> setUserProperty(String name, String value);
  NavigatorObserver? get observer;
}
