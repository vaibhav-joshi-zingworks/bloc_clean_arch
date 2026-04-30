import 'package:bloc_clean_arch/app/bootstrap/app_initializer_cubit.dart';
import 'package:bloc_clean_arch/app/providers/app_message.dart';
import 'package:bloc_clean_arch/app/providers/global_message_cubit.dart';
import 'package:bloc_clean_arch/app/providers/locale_cubit.dart';
import 'package:bloc_clean_arch/app/view/app.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/repositories/theme_repository.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAppInitializerCubit mockAppInitializerCubit;
  late MockGlobalMessageCubit mockGlobalMessageCubit;

  setUp(() async {
    await sl.reset();

    SharedPreferences.setMockInitialValues({});

    // -------------------------------
    // ✅ Router (REAL - NOT MOCK)
    // -------------------------------
    sl.registerLazySingleton<GoRouter>(
          () => GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const Scaffold(
              body: Text('Home'),
            ),
          ),
        ],
      ),
    );

    // -------------------------------
    // ✅ ThemeCubit (REAL)
    // -------------------------------
    sl.registerLazySingleton<ThemeCubit>(
          () => ThemeCubit(
        FakeLoadTheme(),
        FakeSaveTheme(),
        FakeBrightness(),
      ),
    );

    // -------------------------------
    // ✅ LocaleCubit (FAKE)
    // -------------------------------
    sl.registerLazySingleton<LocaleCubit>(
          () => FakeLocaleCubit(),
    );

    // -------------------------------
    // 🔥 GlobalMessageCubit (FIXED)
    // -------------------------------
    mockGlobalMessageCubit = MockGlobalMessageCubit();

    when(() => mockGlobalMessageCubit.state).thenReturn(null);

    whenListen(
      mockGlobalMessageCubit,
      const Stream<AppMessage?>.empty(),
      initialState: null,
    );

    sl.registerLazySingleton<GlobalMessageCubit>(
          () => mockGlobalMessageCubit,
    );

    // -------------------------------
    // 🔥 AppInitializerCubit
    // -------------------------------
    mockAppInitializerCubit = MockAppInitializerCubit();

    when(() => mockAppInitializerCubit.initialize())
        .thenAnswer((_) async {});

    when(() => mockAppInitializerCubit.state).thenReturn(null);

    whenListen(
      mockAppInitializerCubit,
      const Stream<void>.empty(),
      initialState: null,
    );

    sl.registerLazySingleton<AppInitializerCubit>(
          () => mockAppInitializerCubit,
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  // -------------------------------
  // ✅ TESTS
  // -------------------------------
  group('App Widget Tests', () {
    testWidgets('App boots and renders MaterialApp', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('App renders at least one Scaffold', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsAtLeastNWidgets(1));
    });

    testWidgets('App does not crash on startup', (tester) async {
      await tester.pumpWidget(const App());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}

//
// 🔥 MOCKS
//

class MockAppInitializerCubit extends MockCubit<void>
    implements AppInitializerCubit {}

class MockGlobalMessageCubit extends MockCubit<AppMessage?>
    implements GlobalMessageCubit {}

//
// 🔥 FAKES
//

class FakeLocaleCubit extends Cubit<Locale?> implements LocaleCubit {
  FakeLocaleCubit() : super(const Locale('en'));

  @override
  void setArabic() => emit(const Locale('ar'));

  @override
  void setEnglish() => emit(const Locale('en'));

  @override
  void setLocale(Locale? locale) => emit(locale);

  @override
  void useSystemLocale() => emit(null);
}

class FakeLoadTheme extends LoadThemeModeUseCase {
  FakeLoadTheme() : super(FakeThemeRepo());

  @override
  Future<ThemeMode> call() async => ThemeMode.light;
}

class FakeSaveTheme extends SaveThemeModeUseCase {
  FakeSaveTheme() : super(FakeThemeRepo());

  @override
  Future<void> call(ThemeMode mode) async {}
}

class FakeBrightness implements BrightnessProvider {
  @override
  Brightness getBrightness() => Brightness.light;
}

class FakeThemeRepo implements ThemeRepository {
  @override
  Future<ThemeMode> loadThemeMode() async => ThemeMode.light;

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {}
}