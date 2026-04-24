abstract class StorageFacade {
  Future<void> save({required String key, required String value});
  Future<String?> read(String key);
  Future<void> remove(String key);
  Future<void> clearAll();
}
