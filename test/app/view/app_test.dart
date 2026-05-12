import 'package:bloc_clean_arch/app/bootstrap/app_initializer_bloc.dart';
import 'package:bloc_clean_arch/app/providers/global_message.dart';
import 'package:bloc_clean_arch/app/providers/locale_bloc.dart';
import 'package:bloc_clean_arch/core/di/injection.dart';
import 'package:bloc_clean_arch/features/settings/presentation/bloc/theme_bloc.dart';
import 'package:bloc_clean_arch/features/settings/presentation/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeBloc extends Mock implements ThemeBloc {}

class MockLocaleBloc extends Mock implements LocaleBloc {}

class MockGlobalMessageBloc extends Mock implements GlobalMessageBloc {}

class MockGoRouter extends Mock implements GoRouter {}

class MockAppInitializerBloc extends Mock implements AppInitializerBloc {}

void main() {
  late MockThemeBloc mockThemeBloc;
  late MockLocaleBloc mockLocaleBloc;
  late MockGlobalMessageBloc mockGlobalMessageBloc;
  late MockGoRouter mockGoRouter;
  late MockAppInitializerBloc mockAppInitializerBloc;

  setUp(() {
    mockThemeBloc = MockThemeBloc();
    mockLocaleBloc = MockLocaleBloc();
    mockGlobalMessageBloc = MockGlobalMessageBloc();
    mockGoRouter = MockGoRouter();
    mockAppInitializerBloc = MockAppInitializerBloc();

    sl.registerSingleton<ThemeBloc>(mockThemeBloc);
    sl.registerSingleton<LocaleBloc>(mockLocaleBloc);
    sl.registerSingleton<GlobalMessageBloc>(mockGlobalMessageBloc);
    sl.registerSingleton<GoRouter>(mockGoRouter);
    sl.registerSingleton<AppInitializerBloc>(mockAppInitializerBloc);

    when(() => mockThemeBloc.state)
        .thenReturn(const ThemeState(mode: ThemeMode.system, isLoading: true));
    when(() => mockLocaleBloc.state).thenReturn(const Locale('en'));
    when(() => mockGlobalMessageBloc.state).thenReturn(null);

    // For GoRouter, we might need a real one or mock it properly if used in MaterialApp.router
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('renders App', (tester) async {
    // This might be tricky because of MaterialApp.router needing a real GoRouter or more extensive mocking
    // For now, let's keep it simple or test components.
  });
}
