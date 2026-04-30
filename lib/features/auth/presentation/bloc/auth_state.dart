import '../../../../core.dart';
import '../../domain/entity/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.loading() = AuthLoading;
  const factory AuthState.success({required UserEntity user}) = AuthSuccess;
  const factory AuthState.failure({required AppException appException}) = AuthFailure;
}
