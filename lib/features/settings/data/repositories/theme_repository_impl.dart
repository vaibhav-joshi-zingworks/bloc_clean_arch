import 'package:flutter/material.dart';

import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource _localDataSource;

  ThemeRepositoryImpl(this._localDataSource);

  @override
  Future<ThemeMode> loadThemeMode() {
    return _localDataSource.load();
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) {
    return _localDataSource.save(mode);
  }
}
