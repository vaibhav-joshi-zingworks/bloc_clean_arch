import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/bloc/theme_event.dart';
import 'package:bloc_clean_arch/features/settings/presentation/bloc/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bloc responsible for managing the application's theme state.
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(
    this._loadThemeModeUseCase,
    this._saveThemeModeUseCase,
    this._brightnessProvider,
  ) : super(const ThemeState(mode: ThemeMode.system, isLoading: true)) {
    on<ThemeLoadRequested>(_onLoadRequested);
    on<ThemeModeChanged>(_onModeChanged);
    on<ThemeToggleRequested>(_onToggleRequested);
  }

  final LoadThemeModeUseCase _loadThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;
  final BrightnessProvider _brightnessProvider;

  Future<void> _onLoadRequested(
    ThemeLoadRequested event,
    Emitter<ThemeState> emit,
  ) async {
    final mode = await _loadThemeModeUseCase();
    emit(ThemeState(mode: mode, isLoading: false));
  }

  Future<void> _onModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(mode: event.mode));
    await _saveThemeModeUseCase(event.mode);
  }

  Future<void> _onToggleRequested(
    ThemeToggleRequested event,
    Emitter<ThemeState> emit,
  ) async {
    final brightness = _brightnessProvider.getBrightness();
    final newMode = switch (state.mode) {
      ThemeMode.system =>
        brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
    };

    emit(state.copyWith(mode: newMode));
    await _saveThemeModeUseCase(newMode);
  }
}
