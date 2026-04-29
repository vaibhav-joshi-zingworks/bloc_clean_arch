import 'package:bloc_clean_arch/app/storage_keys.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/features/settings/data/datasources/theme_local_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageFacade extends Mock implements StorageFacade {}

void main() {
  late ThemeLocalDataSource dataSource;
  late MockStorageFacade mockStorage;

  setUp(() {
    mockStorage = MockStorageFacade();
    dataSource = ThemeLocalDataSource(mockStorage);
  });

  group('ThemeLocalDataSource', () {
    test('save should call storage.save with correct key and value', () async {
      when(() => mockStorage.save(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => {});
      
      await dataSource.save(ThemeMode.dark);
      
      verify(() => mockStorage.save(
        key: SettingsStorageKeys.themeMode,
        value: ThemeMode.dark.name,
      )).called(1);
    });

    test('load should return correct ThemeMode from storage', () async {
      when(() => mockStorage.read(SettingsStorageKeys.themeMode))
          .thenAnswer((_) async => ThemeMode.light.name);
      
      final result = await dataSource.load();
      
      expect(result, ThemeMode.light);
    });

    test('load should return system if storage value is null', () async {
      when(() => mockStorage.read(any())).thenAnswer((_) async => null);
      final result = await dataSource.load();
      expect(result, ThemeMode.system);
    });
  });
}
