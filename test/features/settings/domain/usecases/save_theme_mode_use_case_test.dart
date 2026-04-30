import 'package:bloc_clean_arch/features/settings/domain/repositories/theme_repository.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  late SaveThemeModeUseCase useCase;
  late MockThemeRepository mockThemeRepository;

  setUp(() {
    registerFallbackValue(ThemeMode.system);
    mockThemeRepository = MockThemeRepository();
    useCase = SaveThemeModeUseCase(mockThemeRepository);
  });

  test('should save theme mode in the repository', () async {
    // arrange
    when(() => mockThemeRepository.saveThemeMode(any()))
        .thenAnswer((_) async => {});
    // act
    await useCase(ThemeMode.light);
    // assert
    verify(() => mockThemeRepository.saveThemeMode(ThemeMode.light));
    verifyNoMoreInteractions(mockThemeRepository);
  });
}
