import 'package:flutter/material.dart';

/// Abstract contract for theme-related persistence operations.
abstract class ThemeRepository {
  /// Loads the saved [ThemeMode] from persistence.
  Future<ThemeMode> loadThemeMode();
  
  /// Persists the selected [ThemeMode] to storage.
  Future<void> saveThemeMode(ThemeMode mode);
}
