import '../../xcore.dart';

/// Abstract factory for creating [StorageFacade] instances based on the requested engine.
abstract class StorageStrategyFactory {
  /// Asynchronously creates a storage facade for the given [engine] type.
  Future<StorageFacade> create(StorageEngine engine);
}
