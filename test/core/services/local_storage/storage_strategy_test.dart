import 'package:bloc_clean_arch/core/services/local_storage/domain/strategies/storage_strategy.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageStrategy extends Mock implements StorageStrategy {}

void main() {
  group('StorageStrategy', () {
    test('can be mocked', () {
      final strategy = MockStorageStrategy();
      expect(strategy, isA<StorageStrategy>());
    });
  });
}
