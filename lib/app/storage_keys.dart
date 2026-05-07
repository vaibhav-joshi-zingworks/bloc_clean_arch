/// Static keys used for local storage persistence (SharedPrefs/SecureStorage).
/// 
/// Centralizing keys prevents hardcoded string errors across the app.
abstract final class SettingsStorageKeys {
  /// Stores the selected theme mode (light/dark/system).
  static const themeMode = 'settings.theme_mode';
}
