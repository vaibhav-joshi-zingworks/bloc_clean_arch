import 'package:bloc_clean_arch/core/services/local_storage/domain/factories/storage_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageStrategyFactory extends Mock implements StorageStrategyFactory {}

void main() {
  group('StorageStrategyFactory', () {
    test('can be mocked', () {
      final factory = MockStorageStrategyFactory();
      expect(factory, isA<StorageStrategyFactory>());
    });
  });
}
