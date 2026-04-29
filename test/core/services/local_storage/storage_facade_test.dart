import 'package:bloc_clean_arch/core/services/local_storage/domain/facades/storage_facade.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageFacade extends Mock implements StorageFacade {}

void main() {
  group('StorageFacade', () {
    test('can be mocked', () {
      final facade = MockStorageFacade();
      expect(facade, isA<StorageFacade>());
    });
  });
}
