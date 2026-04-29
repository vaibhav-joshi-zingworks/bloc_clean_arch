import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/auth/domain/entity/user_entity.dart';
import 'package:bloc_clean_arch/features/auth/domain/usecases/login_usecase.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_event.dart';
import 'package:bloc_clean_arch/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late AuthBloc authBloc;
  late MockLoginUseCase mockLoginUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    authBloc = AuthBloc(loginUseCase: mockLoginUseCase);
  });

  tearDown(() {
    authBloc.close();
  });

  final tUser = UserEntity(
    id: 1,
    name: 'Test User',
    email: 'test@example.com',
  );

  final tLoginParams = LoginParams(
    email: 'test@example.com',
    password: 'password123',
  );

  group('AuthBloc', () {
    test('initial state should be AuthInitial', () {
      expect(authBloc.state, const AuthState.initial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when login is successful',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Right(tUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthState.loading(),
        AuthState.success(user: tUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when login fails with AppException',
      build: () {
        when(() => mockLoginUseCase(any()))
            .thenAnswer((_) async => Left(UnauthorizedError()));
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthState.loading(),
        isA<AuthFailure>().having(
          (f) => f.appException,
          'appException',
          isA<UnauthorizedError>(),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when an unknown error occurs',
      build: () {
        when(() => mockLoginUseCase(any())).thenThrow(Exception());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthState.loading(),
        isA<AuthFailure>().having(
          (f) => f.appException,
          'appException',
          isA<UnknownError>(),
        ),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'does not emit new states when login is already in progress',
      build: () {
        // Slow response to keep it in progress
        when(() => mockLoginUseCase(any())).thenAnswer(
          (_) async => Future.delayed(
            const Duration(milliseconds: 100),
            () => Right(tUser),
          ),
        );
        return authBloc;
      },
      act: (bloc) async {
        bloc.add(const AuthEvent.loginRequested(
          email: 'test@example.com',
          password: 'password123',
        ));
        bloc.add(const AuthEvent.loginRequested(
          email: 'test2@example.com',
          password: 'password456',
        ));
      },
      expect: () => [
        const AuthState.loading(),
        AuthState.success(user: tUser),
      ],
      verify: (_) {
        verify(() => mockLoginUseCase(any())).called(1);
      },
    );
    
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] with TimeoutError when LoginUseCase throws TimeoutError',
      build: () {
        when(() => mockLoginUseCase(any())).thenThrow(TimeoutError());
        return authBloc;
      },
      act: (bloc) => bloc.add(const AuthEvent.loginRequested(
        email: 'test@example.com',
        password: 'password123',
      )),
      expect: () => [
        const AuthState.loading(),
        isA<AuthFailure>().having(
          (f) => f.appException,
          'appException',
          isA<TimeoutError>(),
        ),
      ],
    );
  });
  
  // Register fallback value for LoginParams if needed by mocktail
  setUpAll(() {
    registerFallbackValue(tLoginParams);
  });
}
