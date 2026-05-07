import 'package:freezed_annotation/freezed_annotation.dart';

part 'splash_event.freezed.dart';

/// Events that can be triggered on the [SplashBloc].
@freezed
class SplashEvent with _$SplashEvent {
  /// Initial event triggered when the Splash screen is first displayed.
  const factory SplashEvent.started() = _Started;
}