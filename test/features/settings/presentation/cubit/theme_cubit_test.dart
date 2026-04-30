import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoadThemeModeUseCase extends Mock implements LoadThemeModeUseCase {}
class MockSaveThemeModeUseCase extends Mock implements SaveThemeModeUseCase {}
class MockBrightnessProvider extends Mock implements BrightnessProvider {}

void main() {
  late ThemeCubit themeCubit;
  late MockLoadThemeModeUseCase mockLoadThemeModeUseCase;
  late MockSaveThemeModeUseCase mockSaveThemeModeUseCase;
  late MockBrightnessProvider mockBrightnessProvider;

  setUpAll(() {
    registerFallbackValue(ThemeMode.system);
  });

  setUp(() {
    mockLoadThemeModeUseCase = MockLoadThemeModeUseCase();
    mockSaveThemeModeUseCase = MockSaveThemeModeUseCase();
    mockBrightnessProvider = MockBrightnessProvider();

    themeCubit = ThemeCubit(
      mockLoadThemeModeUseCase,
      mockSaveThemeModeUseCase,
      mockBrightnessProvider,
    );
  });

  tearDown(() {
    themeCubit.close();
  });

  // ✅ Initial State
  test('initial state should be system and isLoading true', () {
    expect(
      themeCubit.state,
      const ThemeState(mode: ThemeMode.system, isLoading: true),
    );
  });

  // ✅ Load Theme
  blocTest<ThemeCubit, ThemeState>(
    'emits correct ThemeMode when loadTheme is called',
    build: () {
      when(() => mockLoadThemeModeUseCase())
          .thenAnswer((_) async => ThemeMode.dark);
      return themeCubit;
    },
    act: (cubit) => cubit.loadTheme(),
    expect: () => [
      const ThemeState(mode: ThemeMode.dark, isLoading: false),
    ],
  );

  // ✅ Set Theme
  blocTest<ThemeCubit, ThemeState>(
    'emits correct ThemeMode and saves it when setThemeMode is called',
    build: () {
      when(() => mockSaveThemeModeUseCase(any()))
          .thenAnswer((_) async {});
      return themeCubit;
    },
    act: (cubit) => cubit.setThemeMode(ThemeMode.light),
    expect: () => [
      const ThemeState(mode: ThemeMode.light, isLoading: true),
    ],
    verify: (_) {
      verify(() => mockSaveThemeModeUseCase(ThemeMode.light)).called(1);
    },
  );

  // ✅ Toggle Tests
  group('toggle', () {
    blocTest<ThemeCubit, ThemeState>(
      'toggles from system (light brightness) to dark',
      build: () {
        when(() => mockBrightnessProvider.getBrightness())
            .thenReturn(Brightness.light);

        when(() => mockSaveThemeModeUseCase(any()))
            .thenAnswer((_) async {});
        return themeCubit;
      },
      act: (cubit) => cubit.toggle(),
      expect: () => [
        const ThemeState(mode: ThemeMode.dark, isLoading: true),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'toggles from system (dark brightness) to light',
      build: () {
        when(() => mockBrightnessProvider.getBrightness())
            .thenReturn(Brightness.dark);

        when(() => mockSaveThemeModeUseCase(any()))
            .thenAnswer((_) async {});
        return themeCubit;
      },
      act: (cubit) => cubit.toggle(),
      expect: () => [
        const ThemeState(mode: ThemeMode.light, isLoading: true),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'toggles from light to dark',
      seed: () => const ThemeState(mode: ThemeMode.light, isLoading: false),
      build: () {
        when(() => mockBrightnessProvider.getBrightness())
            .thenReturn(Brightness.light);

        when(() => mockSaveThemeModeUseCase(any()))
            .thenAnswer((_) async {});
        return themeCubit;
      },
      act: (cubit) => cubit.toggle(),
      expect: () => [
        const ThemeState(mode: ThemeMode.dark, isLoading: false),
      ],
    );

    blocTest<ThemeCubit, ThemeState>(
      'toggles from dark to light',
      seed: () => const ThemeState(mode: ThemeMode.dark, isLoading: false),
      build: () {
        when(() => mockBrightnessProvider.getBrightness())
            .thenReturn(Brightness.dark);

        when(() => mockSaveThemeModeUseCase(any()))
            .thenAnswer((_) async {});
        return themeCubit;
      },
      act: (cubit) => cubit.toggle(),
      expect: () => [
        const ThemeState(mode: ThemeMode.light, isLoading: false),
      ],
    );
  });
}