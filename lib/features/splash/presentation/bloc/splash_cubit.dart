import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_app_status_usecase.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final GetAppStatusUseCase _getAppStatus;

  SplashCubit(this._getAppStatus) : super(const SplashState());

  Future<void> init() async {
    final status = await _getAppStatus();
    emit(state.copyWith(status: status));
  }
}