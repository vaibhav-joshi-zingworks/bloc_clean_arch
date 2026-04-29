import 'package:bloc_clean_arch/core/services/local_storage/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

class InMemoryStorageStrategy implements StorageStrategy {
  final Map<String, String> _store = {};

  @override
  Future<void> write(String key, String value) async {
    _store[key] = value;
  }

  @override
  Future<String?> read(String key) async => _store[key];

  @override
  Future<void> delete(String key) async {
    _store.remove(key);
  }

  @override
  Future<void> clear() async {
    _store.clear();
  }
}

class InMemoryStorageFacade implements StorageFacade {
  InMemoryStorageFacade(this._strategy);

  final StorageStrategy _strategy;

  @override
  Future<void> save({required String key, required String value}) async {
    await _strategy.write(key, value);
  }

  @override
  Future<String?> read(String key) => _strategy.read(key);

  @override
  Future<void> remove(String key) => _strategy.delete(key);

  @override
  Future<void> clearAll() => _strategy.clear();
}

class TestStorageStrategyFactory implements StorageStrategyFactory {
  @override
  Future<StorageFacade> create(StorageEngine engine) async {
    // engine isn't used in this in-memory test implementation.
    return InMemoryStorageFacade(InMemoryStorageStrategy());
  }
}

void main() {
  group('StorageEngine', () {
    test('should include all supported engines', () {
      expect(
        StorageEngine.values,
        containsAll(<StorageEngine>[
          StorageEngine.sharedPreferences,
          StorageEngine.secureStorage,
          StorageEngine.hive,
          StorageEngine.isar,
          StorageEngine.drift,
        ]),
      );
    });
  });

  group('StorageStrategy', () {
    test('write/read/delete/clear should behave as expected', () async {
      final strategy = InMemoryStorageStrategy();

      await strategy.write('k', 'v');
      expect(await strategy.read('k'), 'v');

      await strategy.delete('k');
      expect(await strategy.read('k'), isNull);

      await strategy.write('k1', 'v1');
      await strategy.write('k2', 'v2');
      await strategy.clear();
      expect(await strategy.read('k1'), isNull);
      expect(await strategy.read('k2'), isNull);
    });
  });

  group('StorageFacade', () {
    test('save/read/remove/clearAll should map to strategy', () async {
      final strategy = InMemoryStorageStrategy();
      final facade = InMemoryStorageFacade(strategy);

      await facade.save(key: 'k', value: 'v');
      expect(await facade.read('k'), 'v');

      await facade.remove('k');
      expect(await facade.read('k'), isNull);

      await facade.save(key: 'k1', value: 'v1');
      await facade.clearAll();
      expect(await facade.read('k1'), isNull);
    });
  });

  group('StorageStrategyFactory', () {
    test('should create a StorageFacade for a given engine', () async {
      final factory = TestStorageStrategyFactory();
      final facade = await factory.create(StorageEngine.secureStorage);

      await facade.save(key: 'k', value: 'v');
      expect(await facade.read('k'), 'v');
    });
  });
}

