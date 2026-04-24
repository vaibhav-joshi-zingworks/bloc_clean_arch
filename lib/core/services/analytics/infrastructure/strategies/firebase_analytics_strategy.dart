import 'dart:async';

import '../../../../../core.dart';

class FirebaseAnalyticsStrategy implements AnalyticsStrategy {
  final FirebaseAnalytics analytics;

  bool _initialized = false;

  FirebaseAnalyticsStrategy(this.analytics);

  @override
  NavigatorObserver get observer => FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Future<void> init({bool isEnabled = true}) async {
    if (_initialized) return;

    try {
      await analytics.setAnalyticsCollectionEnabled(isEnabled);
      _initialized = true;
      analytics.logAppOpen();
    } catch (e, stack) {
      _logError('init', e, stack);
    }
  }

  @override
  Future<void> logEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      if (!_initialized) return;
      await analytics.logEvent(name: name, parameters: parameters);
    } catch (e, stack) {
      _logError('logEvent: $name', e, stack);
    }
  }

  @override
  Future<void> setUserId(String userId) async {
    try {
      if (!_initialized) return;
      await analytics.setUserId(id: userId);
    } catch (e, stack) {
      _logError('setUserId', e, stack);
    }
  }

  @override
  Future<void> setUserProperty(String name, String value) async {
    try {
      if (!_initialized) return;
      await analytics.setUserProperty(name: name, value: value);
    } catch (e, stack) {
      _logError('setUserProperty: $name', e, stack);
    }
  }

  void _logError(String method, Object error, StackTrace stack) {
    logError('[FirebaseAnalyticsStrategy][$method] $error');
  }
}
