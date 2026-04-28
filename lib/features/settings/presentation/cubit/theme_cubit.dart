import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/load_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/domain/usecases/save_theme_mode_use_case.dart';
import 'package:bloc_clean_arch/features/settings/presentation/cubit/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit(
      this._loadThemeModeUseCase,
      this._saveThemeModeUseCase,
      this._brightnessProvider,
      ) : super(const ThemeState(mode: ThemeMode.system, isLoading: true));
  final LoadThemeModeUseCase _loadThemeModeUseCase;
  final SaveThemeModeUseCase _saveThemeModeUseCase;
  final BrightnessProvider _brightnessProvider;

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