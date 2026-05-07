/// Abstract interface for key-value local storage operations.
/// 
/// This facade allows the app to perform storage tasks without knowing 
/// whether the underlying engine is Shared Preferences, Secure Storage, or Hive.
abstract class StorageFacade {
  /// Persists a [value] associated with a unique [key].
  Future<void> save({required String key, required String value});
  
  /// Retrieves a value for the given [key], returns null if not found.
  Future<String?> read(String key);
  
  /// Deletes the value associated with [key].
  Future<void> remove(String key);
  
  /// Wipes all data from the storage instance.
  Future<void> clearAll();
}
