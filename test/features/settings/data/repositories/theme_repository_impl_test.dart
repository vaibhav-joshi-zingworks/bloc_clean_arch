import 'package:bloc_clean_arch/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:bloc_clean_arch/features/settings/data/repositories/theme_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeLocalDataSource extends Mock implements ThemeLocalDataSource {}

void main() {
  late ThemeRepositoryImpl repository;
  late MockThemeLocalDataSource mockLocalDataSource;

  setUp(() {
    registerFallbackValue(ThemeMode.system);
    mockLocalDataSource = MockThemeLocalDataSource();
    repository = ThemeRepositoryImpl(mockLocalDataSource);
  });

  test('should call load from local data source', () async {
    // arrange
    when(() => mockLocalDataSource.load()).thenAnswer((_) async => ThemeMode.dark);
    // act
    final result = await repository.loadThemeMode();
    // assert
    expect(result, ThemeMode.dark);
    verify(() => mockLocalDataSource.load()).called(1);
  });

  test('should call save from local data source', () async {
    // arrange
    when(() => mockLocalDataSource.save(any())).thenAnswer((_) async => {});
    // act
    await repository.saveThemeMode(ThemeMode.light);
    // assert
    verify(() => mockLocalDataSource.save(ThemeMode.light)).called(1);
  });
}
