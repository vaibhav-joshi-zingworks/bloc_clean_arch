import '../../../../app/storage_keys.dart';
import '../../../../core.dart';

class ThemeLocalDataSource {
  final StorageFacade _storage;

  ThemeLocalDataSource(this._storage);

  Future<void> save(ThemeMode mode) async {
    await _storage.save(
      key: SettingsStorageKeys.themeMode,
      value: mode.name,
    );
  }

  Future<ThemeMode> load() async {
    final value = await _storage.read(SettingsStorageKeys.themeMode);

    if (value == null) return ThemeMode.system;

    return ThemeMode.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeMode.system,
    );
  }
}
