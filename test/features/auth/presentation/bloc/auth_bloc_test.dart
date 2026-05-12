import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/auth_session_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/login_use_case.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/logout_use_case.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockLogoutUseCase mockLogoutUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockLogoutUseCase = MockLogoutUseCase();
    authBloc = AuthBloc(mockLoginUseCase, mockLogoutUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  const tSession = AuthSessionEntity(
    user: UserEntity(
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
    ),
    accessToken: 'access-token',
    refreshToken: 'refresh-token',
  );

  const tLoginParams = LoginParams(
    email: 'test@example.com',
    password: 'password123',
  );

  group('AuthBloc', () {
    test('initial state should be AuthInitialState', () {
      expect(authBloc.state, const AuthInitialState());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, AuthSuccessState] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => const Right(tSession));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthLoadingState(),
        const AuthSuccessState(session: tSession),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, AuthFailureState] when login fails with AppException',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Left(UnauthorizedError()));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthLoadingState(),
        isA<AuthFailureState>().having(
          (AuthFailureState f) => f.appException,
          'appException',
          isA<UnauthorizedError>(),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, AuthFailureState] when an unknown error occurs',
      build: () {
        when(() => mockLoginUseCase(any())).thenThrow(Exception());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthLoadingState(),
        isA<AuthFailureState>().having(
          (AuthFailureState f) => f.appException,
          'appException',
          isA<UnknownError>(),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'does not emit new states when login is already in progress',
      build: () {
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => Future.delayed(
            const Duration(milliseconds: 100),
            () => const Right(tSession),
          ),
        );
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(const AuthLoginRequested(
          email: 'test@example.com',
          password: 'password123',
        ));
        bloc.add(const AuthLoginRequested(
          email: 'test2@example.com',
          password: 'password456',
        ));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        const AuthLoadingState(),
        const AuthSuccessState(session: tSession),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, AuthFailureState] with TimeoutError when LoginUseCase throws TimeoutError',
      build: () {
        when(() => mockLoginUseCase(any())).thenThrow(TimeoutError());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthLoginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthLoadingState(),
        isA<AuthFailureState>().having(
          (AuthFailureState f) => f.appException,
          'appException',
          isA<TimeoutError>(),
        ),
      ],
    );
  });

  setUpAll(() {
    registerFallbackValue(tLoginParams);
    registerFallbackValue(NoParams());
  });
}
