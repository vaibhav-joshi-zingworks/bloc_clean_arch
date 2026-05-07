import '../../../../app/storage_keys.dart';
import '../../../../core.dart';

/// Data source for managing theme persistence in local storage.
class ThemeLocalDataSource {
  final StorageFacade _storage;

  ThemeLocalDataSource(this._storage);

  /// Saves the [ThemeMode] string value to the local storage facade.
  Future<void> save(ThemeMode mode) async {
    await _storage.save(
      key: SettingsStorageKeys.themeMode,
      value: mode.name,
    );
  }

  /// Loads the [ThemeMode] from the local storage facade.
  /// 
  /// Falls back to [ThemeMode.system] if no value is found.
  Future<ThemeMode> load() async {
    final value = await _storage.read(SettingsStorageKeys.themeMode);

    if (value == null) return ThemeMode.system;

    // Convert the stored string back to a ThemeMode enum
    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
