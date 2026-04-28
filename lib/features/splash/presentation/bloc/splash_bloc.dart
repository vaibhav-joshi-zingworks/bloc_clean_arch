import 'package:bloc_clean_arch/features/splash/domain/usecases/get_app_status_usecase.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc(this._getAppStatus)
      : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.map(
        started: (_) => _onStarted(emit),
      );
    });
  }
  final GetAppStatusUseCase _getAppStatus;

  Future<void> _onStarted(Emitter<SplashState> emit) async {
    emit(const SplashState.loading());

    try {
      final status = await _getAppStatus();

      emit(SplashState.loaded(status));
    } catch (e) {
      emit(SplashState.error(e.toString()));
    }
  }
}