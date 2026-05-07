import '../../xcore.dart';

/// Implementation of [StorageFacade] that delegates operations to a [StorageStrategy].
/// 
/// This allows for switching the underlying storage mechanism (e.g., from 
/// SharedPreferences to SecureStorage) by simply providing a different strategy.
class StrategyBasedStorageFacade implements StorageFacade {
  final StorageStrategy _strategy;

  StrategyBasedStorageFacade(this._strategy);

  @override
  Future<void> save({required String key, required String value}) async {
    await _strategy.write(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return _strategy.read(key);
  }

  @override
  Future<void> remove(String key) async {
    await _strategy.delete(key);
  }

  @override
  Future<void> clearAll() async {
    await _strategy.clear();
  }
}
