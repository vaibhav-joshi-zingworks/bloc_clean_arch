import 'package:bloc_clean_arch/core/services/local_storage/enum/enums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalStorage Enums', () {
    test('StorageEngine should have expected values', () {
      expect(StorageEngine.values, contains(StorageEngine.sharedPreferences));
      expect(StorageEngine.values, contains(StorageEngine.secureStorage));
    });
  });
}
