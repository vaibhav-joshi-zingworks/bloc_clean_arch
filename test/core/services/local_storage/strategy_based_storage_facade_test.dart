import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageStrategy extends Mock implements StorageStrategy {}

void main() {
  late StrategyBasedStorageFacade facade;
  late MockStorageStrategy mockStrategy;

  setUp(() {
    mockStrategy = MockStorageStrategy();
    facade = StrategyBasedStorageFacade(mockStrategy);
  });

  group('StrategyBasedStorageFacade', () {
    test('save should call strategy.write', () async {
      when(() => mockStrategy.write(any(), any())).thenAnswer((_) async => {});
      await facade.save(key: 'key', value: 'value');
      verify(() => mockStrategy.write('key', 'value')).called(1);
    });

    test('read should call strategy.read', () async {
      when(() => mockStrategy.read(any())).thenAnswer((_) async => 'value');
      final result = await facade.read('key');
      expect(result, 'value');
      verify(() => mockStrategy.read('key')).called(1);
    });

    test('remove should call strategy.delete', () async {
      when(() => mockStrategy.delete(any())).thenAnswer((_) async => {});
      await facade.remove('key');
      verify(() => mockStrategy.delete('key')).called(1);
    });

    test('clearAll should call strategy.clear', () async {
      when(() => mockStrategy.clear()).thenAnswer((_) async => {});
      await facade.clearAll();
      verify(() => mockStrategy.clear()).called(1);
    });
  });
}
