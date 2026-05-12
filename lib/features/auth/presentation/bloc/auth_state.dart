import '../../../../core.dart';
import '../../domain/entity/user_entity.dart';

/// States emitted by the [AuthBloc] during the authentication process.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any login attempt.
class AuthInitialState extends AuthState {
  const AuthInitialState();
}

/// State indicating that a login request is currently being processed.
class AuthLoadingState extends AuthState {
  const AuthLoadingState();
}

/// State indicating that the login was successful, containing the [user] data.
class AuthSuccessState extends AuthState {
  final UserEntity user;

  const AuthSuccessState({required this.user});

  @override
  List<Object?> get props => [user];
}

/// State indicating that the login attempt failed, containing the [appException].
class AuthFailureState extends AuthState {
  final AppException appException;

  const AuthFailureState({required this.appException});

  @override
  List<Object?> get props => [appException];
}
