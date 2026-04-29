import 'package:bloc_clean_arch/core/services/local_storage/infrastructure/strategies/shared_preferences_storage_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferencesStorageStrategy strategy;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    strategy = SharedPreferencesStorageStrategy(mockPrefs);
  });

  group('SharedPreferencesStorageStrategy', () {
    test('write should call setString on SharedPreferences', () async {
      when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);
      await strategy.write('key', 'value');
      verify(() => mockPrefs.setString('key', 'value')).called(1);
    });

    test('read should call getString on SharedPreferences', () async {
      when(() => mockPrefs.getString(any())).thenReturn('value');
      final result = await strategy.read('key');
      expect(result, 'value');
      verify(() => mockPrefs.getString('key')).called(1);
    });

    test('delete should call remove on SharedPreferences', () async {
      when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);
      await strategy.delete('key');
      verify(() => mockPrefs.remove('key')).called(1);
    });

    test('clear should call clear on SharedPreferences', () async {
      when(() => mockPrefs.clear()).thenAnswer((_) async => true);
      await strategy.clear();
      verify(() => mockPrefs.clear()).called(1);
    });
  });
}
