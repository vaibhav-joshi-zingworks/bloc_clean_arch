import '../../xcore.dart';
abstract class StorageStrategyFactory {
  Future<StorageFacade> create(StorageEngine engine);
}
