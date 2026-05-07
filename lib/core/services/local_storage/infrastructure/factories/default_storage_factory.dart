import '../../xcore.dart';

/// Default implementation of [StorageStrategyFactory].
/// 
/// It handles the initialization and creation of specific storage facades, 
/// supporting SharedPreferences and SecureStorage out of the box.
class DefaultStorageStrategyFactory implements StorageStrategyFactory {
  @override
  Future<StorageFacade> create(StorageEngine engine) async {
    switch (engine) {
      case StorageEngine.sharedPreferences:
        // Initialize SharedPreferences and wrap it in a Strategy-based Facade
        final prefs = await SharedPreferences.getInstance();
        final strategy = SharedPreferencesStorageStrategy(prefs);
        return StrategyBasedStorageFacade(strategy);

      case StorageEngine.secureStorage:
        // Create SecureStorage strategy and wrap it in a Strategy-based Facade
        const secureStorage = FlutterSecureStorage();
        final strategy = SecureStorageStrategy(secureStorage);
        return StrategyBasedStorageFacade(strategy);

      case StorageEngine.hive:
      case StorageEngine.isar:
      case StorageEngine.drift:
        // Placeholders for future database-driven storage engines
        throw UnimplementedError('Storage engine $engine not implemented yet');
    }
  }
}
