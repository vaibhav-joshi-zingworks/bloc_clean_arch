import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../core/services/analytics/domain/facades/analytics_facade.dart';
import '../../core/services/notification/domain/strategies/notification_strategy.dart';

@lazySingleton
class AppInitializerCubit extends Cubit<void> {
  final AnalyticsFacade analytics;
  final NotificationStrategy notificationStrategy;

  AppInitializerCubit({
    required this.analytics,
    required this.notificationStrategy,
  }) : super(null);

  Future<void> initialize() async {
    // Run in parallel
    await Future.wait([
      _initNotifications(),
      _initAnalytics(),
    ]);
  }

  Future<void> _initNotifications() async {
    // fire & forget OR await based on your need
    await notificationStrategy.initialize();
  }

  Future<void> _initAnalytics() async {
    await analytics.init(isEnabled: true);
  }
}
