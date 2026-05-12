import 'package:bloc_clean_arch/app/bootstrap/app_initializer_bloc.dart';
import 'package:bloc_clean_arch/app/providers/global_message.dart';
import 'package:bloc_clean_arch/app/providers/locale_bloc.dart';
import 'package:bloc_clean_arch/app/view/app.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/repositories/theme_repository.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAppInitializerBloc mockAppInitializerBloc;
  late MockGlobalMessageBloc mockGlobalMessageBloc;

  setUp(() async {
    await sl.reset();

    // SharedPreferences.setMockInitialValues({});

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
    // ✅ ThemeBloc (REAL)
    // -------------------------------
    sl.registerLazySingleton<ThemeBloc>(
      () => ThemeBloc(
        FakeLoadTheme(),
        FakeSaveTheme(),
        FakeBrightness(),
      ),
    );

    // -------------------------------
    // ✅ LocaleBloc (FAKE)
    // -------------------------------
    sl.registerLazySingleton<LocaleBloc>(
      () => FakeLocaleBloc(),
    );

    // -------------------------------
    // 🔥 GlobalMessageBloc (FIXED)
    // -------------------------------
    mockGlobalMessageBloc = MockGlobalMessageBloc();

    when(() => mockGlobalMessageBloc.state).thenReturn(null);

    whenListen(
      mockGlobalMessageBloc,
      const Stream<AppMessage?>.empty(),
      initialState: null,
    );

    sl.registerLazySingleton<GlobalMessageBloc>(
      () => mockGlobalMessageBloc,
    );

    // -------------------------------
    // 🔥 AppInitializerBloc
    // -------------------------------
    mockAppInitializerBloc = MockAppInitializerBloc();

    when(() => mockAppInitializerBloc.state).thenReturn(null);

    whenListen(
      mockAppInitializerBloc,
      const Stream<void>.empty(),
      initialState: null,
    );

    sl.registerLazySingleton<AppInitializerBloc>(
      () => mockAppInitializerBloc,
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

class MockAppInitializerBloc extends MockBloc<AppInitializerEvent, void>
    implements AppInitializerBloc {}

class MockGlobalMessageBloc extends MockBloc<GlobalMessageEvent, AppMessage?>
    implements GlobalMessageBloc {}

//
// 🔥 FAKES
//

class FakeLocaleBloc extends Bloc<LocaleEvent, Locale?> implements LocaleBloc {
  FakeLocaleBloc() : super(const Locale('en'));
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
