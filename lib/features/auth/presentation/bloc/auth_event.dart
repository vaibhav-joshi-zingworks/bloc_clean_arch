import '../../../../core.dart';

/// Events that can be triggered on the [AuthBloc].
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when a user attempts to log in with [email] and [password].
class AuthLoginRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequestedEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
