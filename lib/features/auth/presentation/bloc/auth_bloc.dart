import 'dart:async';

import 'package:bloc_clean_arch/features/auth/domain/usecases/login_use_case.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/logout_use_case.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core.dart';
import '../../../../core/failure/app_exception.dart';

/// Manages authentication state for the login flow.
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._loginUseCase,
    this._logoutUseCase,
  ) : super(const AuthInitialState()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  bool _isLoginInProgress = false;

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    if (_isLoginInProgress) return;

    _isLoginInProgress = true;
    emit(const AuthLoadingState());

    try {
      final result = await _loginUseCase(
        LoginParams(
          email: event.email,
          password: event.password,
        ),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () => throw TimeoutError(),
      );

      result.fold(
        (failure) => emit(AuthFailureState(appException: failure)),
        (session) => emit(AuthSuccessState(session: session)),
      );
    } on AppException catch (error) {
      emit(AuthFailureState(appException: error));
    } catch (_) {
      emit(AuthFailureState(appException: UnknownError()));
    } finally {
      _isLoginInProgress = false;
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoadingState());

    final result = await _logoutUseCase(NoParams());

    result.fold(
      (failure) => emit(AuthFailureState(appException: failure)),
      (_) => emit(const AuthLoggedOutState()),
    );
  }
}
