/// Settings feature: theme mode (light/dark/system) and persistence.
///
/// Use this barrel for imports outside the feature; other features use folder paths
/// or add their own `xcore.dart` when the public surface grows.
export 'data/datasources/theme_local_data_source.dart';
export 'data/repositories/theme_repository_impl.dart';
export 'domain/repositories/theme_repository.dart';
export 'domain/usecases/load_theme_mode_use_case.dart';
export 'domain/usecases/save_theme_mode_use_case.dart';
export 'presentation/cubit/theme_cubit.dart';
export 'presentation/cubit/theme_state.dart';
