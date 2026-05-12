import '../../../../core.dart';
import '../../domain/entities/auth_session_entity.dart';

/// States emitted by [AuthBloc].
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

class AuthSuccessState extends AuthState {
  final AuthSessionEntity session;

  const AuthSuccessState({required this.session});

  @override
  List<Object?> get props => [session];
}

class AuthFailureState extends AuthState {
  final AppException appException;

  const AuthFailureState({required this.appException});

  @override
  List<Object?> get props => [appException];
}

class AuthLoggedOutState extends AuthState {
  const AuthLoggedOutState();
}
