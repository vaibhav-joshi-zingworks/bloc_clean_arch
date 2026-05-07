import '../../../../core.dart';
import '../../domain/entity/user_entity.dart';

part 'auth_state.freezed.dart';

/// States emitted by the [AuthBloc] during the authentication process.
@freezed
sealed class AuthState with _$AuthState {
  /// Initial state before any login attempt.
  const factory AuthState.initial() = AuthInitial;
  
  /// State indicating that a login request is currently being processed.
  const factory AuthState.loading() = AuthLoading;
  
  /// State indicating that the login was successful, containing the [user] data.
  const factory AuthState.success({required UserEntity user}) = AuthSuccess;
  
  /// State indicating that the login attempt failed, containing the [appException].
  const factory AuthState.failure({required AppException appException}) = AuthFailure;
}
