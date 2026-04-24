import '../../xcore.dart';

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
