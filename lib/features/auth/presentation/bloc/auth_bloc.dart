import 'dart:async';

import 'package:bloc_clean_arch/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core.dart';
import '../../../../core/failure/app_exception.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  bool _isLoginInProgress = false;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    if (_isLoginInProgress) return;

    _isLoginInProgress = true;

    emit(AuthLoading());

    try {
      final result = await loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutError(),
      );

      result.fold(
            (failure) {
          // failure is already AppException → pass directly
          emit(AuthFailure(appException: failure));
        },
            (user) {
          emit(AuthSuccess(user: user));
        },
      );
    }
    on AppException catch (e) {
      emit(AuthFailure(appException: e));
    }
    catch (e) {
      emit(AuthFailure(appException: UnknownError()));
    }
    finally {
      _isLoginInProgress = false;
    }
  }
}