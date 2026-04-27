import 'package:flutter/material.dart';

import '../repositories/theme_repository.dart';

class LoadThemeModeUseCase {
  final ThemeRepository _repository;

  LoadThemeModeUseCase(this._repository);

  Future<ThemeMode> call() {
    return _repository.loadThemeMode();
  }
}
