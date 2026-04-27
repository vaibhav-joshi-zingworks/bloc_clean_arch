import 'package:flutter/material.dart';

import '../repositories/theme_repository.dart';

class SaveThemeModeUseCase {
  final ThemeRepository _repository;

  SaveThemeModeUseCase(this._repository);

  Future<void> call(ThemeMode mode) {
    return _repository.saveThemeMode(mode);
  }
}
