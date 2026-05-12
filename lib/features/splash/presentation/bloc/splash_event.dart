import '../../../../core.dart';

/// Events that can be triggered on the [SplashBloc].
abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

/// Initial event triggered when the Splash screen is first displayed.
class SplashEventStarted extends SplashEvent {
  const SplashEventStarted();
}
// Force re-analysis
