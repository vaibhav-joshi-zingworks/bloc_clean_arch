import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/load_theme_mode_use_case.dart';
import '../../domain/usecases/save_theme_mode_use_case.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final LoadThemeModeUseCase _loadThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;

  ThemeCubit(
    this._loadThemeModeUseCase,
    this._saveThemeModeUseCase,
  ) : super(const ThemeState(mode: ThemeMode.system, isLoading: true));

  Future<void> loadTheme() async {
    final mode = await _loadThemeModeUseCase();
    emit(ThemeState(mode: mode, isLoading: false));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(mode: mode));
    await _saveThemeModeUseCase(mode);
  }

  Future<void> toggle() async {
    final current = state.mode;
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    final newMode = switch (current) {
      ThemeMode.system =>
        brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
    };

    await setThemeMode(newMode);
  }
}
