import 'package:bloc_clean_arch/features/splash/domain/entities/app_status.dart';
import 'package:bloc_clean_arch/features/splash/domain/repositories/splash_repository.dart';
import 'package:bloc_clean_arch/features/splash/domain/usecases/get_app_status_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSplashRepository extends Mock implements SplashRepository {}

void main() {
  late GetAppStatusUseCase useCase;
  late MockSplashRepository mockSplashRepository;

  setUp(() {
    mockSplashRepository = MockSplashRepository();
    useCase = GetAppStatusUseCase(mockSplashRepository);
  });

  test('should get app status from the repository', () async {
    // arrange
    when(() => mockSplashRepository.getAppStatus())
        .thenAnswer((_) async => AppStatus.authenticated);
    // act
    final result = await useCase();
    // assert
    expect(result, AppStatus.authenticated);
    verify(() => mockSplashRepository.getAppStatus());
    verifyNoMoreInteractions(mockSplashRepository);
  });
}
