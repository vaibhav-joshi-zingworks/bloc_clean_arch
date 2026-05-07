import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_status.dart';

part 'splash_state.freezed.dart';

/// States emitted by the [SplashBloc] during the initialization process.
@freezed
class SplashState with _$SplashState {
  /// The initial state before any actions are taken.
  const factory SplashState.initial() = _Initial;

  /// State indicating that the application status is being checked.
  const factory SplashState.loading() = _Loading;

  /// State indicating that the application status has been successfully determined.
  const factory SplashState.loaded(AppStatus status) = _Loaded;

  /// State indicating that an error occurred during the splash process.
  const factory SplashState.error(String message) = _Error;
}