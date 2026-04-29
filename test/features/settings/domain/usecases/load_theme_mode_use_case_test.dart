import 'package:bloc_clean_arch/features/settings/domain/repositories/theme_repository.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  late LoadThemeModeUseCase useCase;
  late MockThemeRepository mockThemeRepository;

  setUp(() {
    mockThemeRepository = MockThemeRepository();
    useCase = LoadThemeModeUseCase(mockThemeRepository);
  });

  test('should load theme mode from the repository', () async {
    // arrange
    when(() => mockThemeRepository.loadThemeMode())
        .thenAnswer((_) async => ThemeMode.dark);
    // act
    final result = await useCase();
    // assert
    expect(result, ThemeMode.dark);
    verify(() => mockThemeRepository.loadThemeMode());
    verifyNoMoreInteractions(mockThemeRepository);
  });
}
