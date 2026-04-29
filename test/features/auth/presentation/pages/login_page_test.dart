import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_clean_arch/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: const LoginPage(),
      ),
    );
  }

  group('LoginPage', () {
    testWidgets('renders email and password text fields', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('adds AuthLoginRequested to AuthBloc when login button is pressed', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.initial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(TextField).at(0), 'test@test.com');
      await tester.enterText(find.byType(TextField).at(1), 'password');
      await tester.tap(find.byType(ElevatedButton));

      verify(() => mockAuthBloc.add(const AuthEvent.loginRequested(
        email: 'test@test.com',
        password: 'password',
      ))).called(1);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.widget<ElevatedButton>(find.byType(ElevatedButton)).enabled, false);
    });

    testWidgets('shows SnackBar when state is failure', (tester) async {
      final exception = AppException(401, 'Invalid credentials');

      whenListen(
        mockAuthBloc,
        Stream.fromIterable([AuthState.failure(appException: exception)]),
        initialState: const AuthState.initial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger listener

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Invalid credentials'), findsOneWidget);
    });
  });
}
