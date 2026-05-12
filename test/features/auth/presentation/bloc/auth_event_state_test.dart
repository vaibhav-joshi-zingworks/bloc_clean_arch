import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEvent', () {
    test('loginRequested support value equality', () {
      expect(
        const AuthLoginRequestedEvent(email: 'e', password: 'p'),
        const AuthLoginRequestedEvent(email: 'e', password: 'p'),
      );
    });
  });

  group('AuthState', () {
    test('initial support value equality', () {
      expect(const AuthInitialState(), const AuthInitialState());
    });

    test('loading support value equality', () {
      expect(const AuthLoadingState(), const AuthLoadingState());
    });

    test('success support value equality', () {
      final user = UserEntity(id: 1, name: 'n', email: 'e');
      expect(
        AuthSuccessState(user: user),
        AuthSuccessState(user: user),
      );
    });
  });
}
// Force re-analysis
