import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/auth_session_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tUser = UserEntity(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
  );

  const tSession = AuthSessionEntity(
    user: tUser,
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
  );

  group('AuthEvent', () {
    test('AuthLoginRequested props should contain email and password', () {
      const event = AuthLoginRequested(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(event.props, ['test@example.com', 'password123']);
    });
  });

  group('AuthState', () {
    test('AuthSuccessState props should contain session', () {
      const state = AuthSuccessState(session: tSession);

      expect(state.props, [tSession]);
    });

    test('AuthFailureState props should contain appException', () {
      final state = AuthFailureState(appException: AppException(401, 'error'));

      expect(state.props, [state.appException]);
    });
  });
}
