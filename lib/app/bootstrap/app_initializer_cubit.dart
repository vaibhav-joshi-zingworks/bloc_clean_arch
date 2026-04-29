import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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

  Future<void> initialize() async {
    await Future.wait([
      _initNotifications(),
      // _initAnalytics(),
    ]);
  }

  Future<void> _initNotifications() async {
    await _notificationStrategy.initialize();
  }

// Future<void> _initAnalytics() async {
//   await _analytics.init(isEnabled: true);
// }
}