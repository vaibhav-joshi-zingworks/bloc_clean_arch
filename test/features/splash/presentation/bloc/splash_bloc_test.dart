import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:bloc_clean_arch/features/splash/domain/usecases/get_app_status_usecase.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_event.dart';
import 'package:bloc_clean_arch/features/splash/presentation/bloc/splash_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAppStatusUseCase extends Mock implements GetAppStatusUseCase {}

void main() {
  late SplashBloc splashBloc;
  late MockGetAppStatusUseCase mockGetAppStatusUseCase;

  setUp(() {
    mockGetAppStatusUseCase = MockGetAppStatusUseCase();
    splashBloc = SplashBloc(mockGetAppStatusUseCase);
  });

  tearDown(() {
    splashBloc.close();
  });

  test('initial state should be SplashInitial', () {
    expect(splashBloc.state, const SplashState.initial());
  });

  blocTest<SplashBloc, SplashState>(
    'emits [SplashLoading, SplashLoaded] when getAppStatus is successful',
    build: () {
      when(() => mockGetAppStatusUseCase())
          .thenAnswer((_) async => AppStatus.authenticated);
      return splashBloc;
    },
    act: (bloc) => bloc.add(const SplashEvent.started()),
    expect: () => [
      const SplashState.loading(),
      const SplashState.loaded(AppStatus.authenticated),
    ],
    verify: (_) {
      verify(() => mockGetAppStatusUseCase()).called(1);
    },
  );

  blocTest<SplashBloc, SplashState>(
    'emits [SplashLoading, SplashError] when getAppStatus fails',
    build: () {
      when(() => mockGetAppStatusUseCase()).thenThrow(Exception('error'));
      return splashBloc;
    },
    act: (bloc) => bloc.add(const SplashEvent.started()),
    expect: () => [
      const SplashState.loading(),
      const SplashState.error('Exception: error'),
    ],
  );
}
