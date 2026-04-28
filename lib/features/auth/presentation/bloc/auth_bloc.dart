import 'dart:async';

import 'package:bloc_clean_arch/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase}) : super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
  }

  FutureOr<void> _onLoginRequested(
      AuthLoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    final result = await loginUseCase(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
          (failure) => emit(AuthFailure(appException: failure)),
          (user) => emit(AuthSuccess(user: user)),
    );
  }
}