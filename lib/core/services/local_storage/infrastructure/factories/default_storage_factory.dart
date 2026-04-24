import '../../xcore.dart';

class DefaultStorageStrategyFactory implements StorageStrategyFactory {
  @override
  Future<StorageFacade> create(StorageEngine engine) async {
    switch (engine) {
      case StorageEngine.sharedPreferences:
        final prefs = await SharedPreferences.getInstance();
        final strategy = SharedPreferencesStorageStrategy(prefs);
        return StrategyBasedStorageFacade(strategy);

      case StorageEngine.secureStorage:
        const secureStorage = FlutterSecureStorage();
        final strategy = SecureStorageStrategy(secureStorage);
        return StrategyBasedStorageFacade(strategy);

      case StorageEngine.hive:
      case StorageEngine.isar:
      case StorageEngine.drift:
        throw UnimplementedError('Storage engine not implemented yet');
    }
  }
}
