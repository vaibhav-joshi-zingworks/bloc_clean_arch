import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

/// Events that can be triggered on the [AuthBloc].
@freezed
sealed class AuthEvent with _$AuthEvent {
  /// Event triggered when a user attempts to log in with [email] and [password].
  const factory AuthEvent.loginRequested({
    required String email,
    required String password,
  }) = AuthLoginRequested;
}
