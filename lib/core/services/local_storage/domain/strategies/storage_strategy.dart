/// Contract for implementing specific storage engines (e.g. Secure Storage, SharedPrefs).
/// 
/// The [StorageFacade] uses these strategies to perform the actual data persistence.
abstract class StorageStrategy {
  /// Writes a [value] to the underlying storage.
  Future<void> write(String key, String value);
  
  /// Reads a value from the underlying storage.
  Future<String?> read(String key);
  
  /// Deletes a specific entry from the underlying storage.
  Future<void> delete(String key);
  
  /// Clears all entries from the underlying storage.
  Future<void> clear();
}
