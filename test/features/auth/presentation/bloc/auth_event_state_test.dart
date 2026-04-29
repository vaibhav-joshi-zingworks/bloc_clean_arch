import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthEvent', () {
    test('loginRequested support value equality', () {
      expect(
        const AuthEvent.loginRequested(email: 'e', password: 'p'),
        const AuthEvent.loginRequested(email: 'e', password: 'p'),
      );
    });
  });

  group('AuthState', () {
    test('initial support value equality', () {
      expect(const AuthState.initial(), const AuthState.initial());
    });

    test('loading support value equality', () {
      expect(const AuthState.loading(), const AuthState.loading());
    });

    test('success support value equality', () {
      final user = UserEntity(id: 1, name: 'n', email: 'e');
      expect(
        AuthState.success(user: user),
        AuthState.success(user: user),
      );
    });
  });
}
