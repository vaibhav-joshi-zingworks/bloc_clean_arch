import 'package:bloc_clean_arch/app/storage_keys.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsStorageKeys', () {
    test('themeMode key should be correct', () {
      expect(SettingsStorageKeys.themeMode, 'settings.theme_mode');
    });
  });
}
