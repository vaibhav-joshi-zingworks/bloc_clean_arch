import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

/// Use case for persisting the user's preferred theme mode.
class SaveThemeModeUseCase {
  final ThemeRepository _repository;

  SaveThemeModeUseCase(this._repository);

  /// Executes the logic to save the given [mode].
  Future<void> call(ThemeMode mode) {
    return _repository.saveThemeMode(mode);
  }
}
