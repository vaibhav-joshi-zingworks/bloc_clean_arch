import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

abstract class AppInitializerEvent extends Equatable {
  const AppInitializerEvent();

  @override
  List<Object?> get props => [];
}

class AppInitializationRequested extends AppInitializerEvent {
  const AppInitializationRequested();
}

/// Bloc responsible for initializing global app services during startup.
@lazySingleton
class AppInitializerBloc extends Bloc<AppInitializerEvent, void> {
  AppInitializerBloc({
    required AnalyticsFacade analytics,
    required NotificationStrategy notificationStrategy,
  })  : _analytics = analytics,
        _notificationStrategy = notificationStrategy,
        super(null) {
    on<AppInitializationRequested>(_onInitializationRequested);
  }

  final AnalyticsFacade _analytics;
  final NotificationStrategy _notificationStrategy;

  Future<void> _onInitializationRequested(
    AppInitializationRequested event,
    Emitter<void> emit,
  ) async {
    await Future.wait([
      _notificationStrategy.initialize(),
      _analytics.init(),
    ]);
  }
}
