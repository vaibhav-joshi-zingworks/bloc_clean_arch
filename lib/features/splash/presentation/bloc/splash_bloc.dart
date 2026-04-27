import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_app_status_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetAppStatusUseCase getAppStatus;

  SplashBloc(this.getAppStatus)
      : super(const SplashState.initial()) {
    on<SplashEvent>((event, emit) async {
      await event.map(
        started: (_) => _onStarted(emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<SplashState> emit) async {
    emit(const SplashState.loading());

    try {
      final status = await getAppStatus();

      emit(SplashState.loaded(status));
    } catch (e) {
      emit(SplashState.error(e.toString()));
    }
  }
}