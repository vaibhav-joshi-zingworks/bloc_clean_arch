import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Cubit responsible for initializing global app services during startup.
/// 
/// This is typically called once the app's root widget is mounted.
@lazySingleton
class AppInitializerCubit extends Cubit<void> {
  AppInitializerCubit({
    required AnalyticsFacade analytics,
    required NotificationStrategy notificationStrategy,
  })  : _analytics = analytics,
        _notificationStrategy = notificationStrategy,
        super(null);

  final AnalyticsFacade _analytics;
  final NotificationStrategy _notificationStrategy;

  /// Entry point for app-wide asynchronous initialization tasks.
  Future<void> initialize() async {
    await Future.wait([
      _initNotifications(),
      _initAnalytics(),
    ]);
  }

  /// Configures and initializes the local/push notification engine.
  Future<void> _initNotifications() async {
    await _notificationStrategy.initialize();
  }

  /// Initializes analytics services (e.g., Firebase Analytics).
  Future<void> _initAnalytics() async {
    // await _analytics.init(isEnabled: true);
  }
}
