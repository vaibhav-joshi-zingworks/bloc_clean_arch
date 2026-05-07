import 'package:bloc_clean_arch/features/splash/domain/usecases/get_app_status_usecase.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

/// Business Logic Component (BLoC) for the Splash screen.
/// 
/// Manages the state for the initial application loading process.
@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAppStatusUseCase _getAppStatus;

  SplashBloc(this._getAppStatus)
      : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      // Map incoming events to their respective handler methods
      await event.map(
        started: (_) => _onStarted(emit),
      );
    });
  }

  /// Handles the 'started' event to trigger initial status check.
  Future<void> _onStarted(Emitter<SplashState> emit) async {
    emit(const SplashState.loading());

    try {
      // Fetch the app status from the domain layer
      final status = await _getAppStatus();

      // Emit success state with the determined status
      emit(SplashState.loaded(status));
    } catch (e) {
      // Emit error state if initialization fails
      emit(SplashState.error(e.toString()));
    }
  }
}
