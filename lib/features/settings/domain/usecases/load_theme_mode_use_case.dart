import 'package:flutter/material.dart';
import '../repositories/theme_repository.dart';

/// Use case for loading the user's preferred theme mode.
class LoadThemeModeUseCase {
  final ThemeRepository _repository;

  LoadThemeModeUseCase(this._repository);

  /// Executes the logic to retrieve the [ThemeMode].
  Future<ThemeMode> call() {
    return _repository.loadThemeMode();
  }
}
