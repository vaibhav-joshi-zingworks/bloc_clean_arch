import '../../../../core.dart';

/// Events handled by [AuthBloc].
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Starts the login flow with the provided credentials.
class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

/// Clears the active authentication session.
class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}
