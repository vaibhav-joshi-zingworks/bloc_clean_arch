import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/app_status.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState.initial() = _Initial;

  const factory SplashState.loading() = _Loading;

  const factory SplashState.loaded(AppStatus status) = _Loaded;

  const factory SplashState.error(String message) = _Error;
}