import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit responsible for managing the application's theme state.
/// 
/// It coordinates loading, saving, and toggling between light, dark, and system themes.
class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit(
      this._loadThemeModeUseCase,
      this._saveThemeModeUseCase,
      this._brightnessProvider,
      ) : super(const ThemeState(mode: ThemeMode.system, isLoading: true));
  
  final LoadThemeModeUseCase _loadThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;
  final BrightnessProvider _brightnessProvider;

  /// Loads the theme mode from persistent storage.
  Future<void> loadTheme() async {
    final mode = await _loadThemeModeUseCase();
    emit(ThemeState(mode: mode, isLoading: false));
  }

  /// Updates the current theme mode and persists the choice.
  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(mode: mode));
    await _saveThemeModeUseCase(mode);
  }

  /// Toggles between light and dark themes.
  /// 
  /// If the current mode is 'system', it determines the next mode 
  /// based on the device's current brightness.
  Future<void> toggle() async {
    final current = state.mode;
    final brightness = _brightnessProvider.getBrightness();

    final newMode = switch (current) {
      ThemeMode.system =>
      brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light,
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.light,
    };

    await setThemeMode(newMode);
  }
}
