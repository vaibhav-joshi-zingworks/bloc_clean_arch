import '../../xcore.dart';

/// Implementation of [StorageStrategy] using [SharedPreferences].
/// 
/// Used for storing non-sensitive data like user preferences, 
/// theme settings, and app flags.
class SharedPreferencesStorageStrategy implements StorageStrategy {
  final SharedPreferences _prefs;

  SharedPreferencesStorageStrategy(this._prefs);

  @override
  Future<void> write(String key, String value) async {
    await _prefs.setString(key, value);
  }

  @override
  Future<String?> read(String key) async {
    return _prefs.getString(key);
  }

  @override
  Future<void> delete(String key) async {
    await _prefs.remove(key);
  }

  @override
  Future<void> clear() async {
    await _prefs.clear();
  }
}
