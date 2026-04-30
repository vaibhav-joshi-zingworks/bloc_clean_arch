import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:bloc_clean_arch/features/splash/presentation/screens/splash_view.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashBloc extends MockBloc<SplashEvent, SplashState> implements SplashBloc {}

void main() {
  late MockSplashBloc mockSplashBloc;

  setUp(() {
    mockSplashBloc = MockSplashBloc();
    
    // Register in GetIt (sl)
    if (sl.isRegistered<SplashBloc>()) {
      sl.unregister<SplashBloc>();
    }
    sl.registerSingleton<SplashBloc>(mockSplashBloc);

    when(() => mockSplashBloc.state).thenReturn(const SplashState.initial());
  });

  tearDown(() {
    sl.reset();
  });

  testWidgets('renders initial state', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SplashView()));
    expect(find.byType(SizedBox), findsWidgets);
  });

  testWidgets('shows loading widget when state is loading', (tester) async {
    when(() => mockSplashBloc.state).thenReturn(const SplashState.loading());
    await tester.pumpWidget(const MaterialApp(home: SplashView()));
    expect(find.byType(AppLoadingWidget), findsOneWidget);
  });

  testWidgets('shows error message when state is error', (tester) async {
    when(() => mockSplashBloc.state).thenReturn(const SplashState.error('Failed'));
    await tester.pumpWidget(const MaterialApp(home: SplashView()));
    expect(find.text('Error: Failed'), findsOneWidget);
  });
}
