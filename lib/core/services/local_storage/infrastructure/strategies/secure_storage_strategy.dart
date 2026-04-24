import '../../xcore.dart';

class SecureStorageStrategy implements StorageStrategy {
  final FlutterSecureStorage _secureStorage;

  SecureStorageStrategy(this._secureStorage);

  @override
  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read(String key) async {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  @override
  Future<void> clear() async {
    await _secureStorage.deleteAll();
  }
}
