import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashEvent', () {
    test('started should support value equality', () {
      expect(const SplashEvent.started(), const SplashEvent.started());
    });
  });

  group('SplashState', () {
    test('initial should support value equality', () {
      expect(const SplashState.initial(), const SplashState.initial());
    });

    test('loaded should support value equality', () {
      expect(
        const SplashState.loaded(AppStatus.authenticated),
        const SplashState.loaded(AppStatus.authenticated),
      );
    });
  });
}
