import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashEvent', () {
    test('started should support value equality', () {
      expect(const SplashEventStarted(), const SplashEventStarted());
    });
  });

  group('SplashState', () {
    test('initial should support value equality', () {
      expect(const SplashInitialState(), const SplashInitialState());
    });

    test('loaded should support value equality', () {
      expect(
        const SplashLoadedState(AppStatus.authenticated),
        const SplashLoadedState(AppStatus.authenticated),
      );
    });
  });
}
