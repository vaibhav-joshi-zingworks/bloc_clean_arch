import '../../../../core.dart';
import '../../domain/entities/app_status.dart';

/// States emitted by the [SplashBloc] during the initialization process.
abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

class SplashInitialState extends SplashState {
  const SplashInitialState();
}

class SplashLoadingState extends SplashState {
  const SplashLoadingState();
}

class SplashLoadedState extends SplashState {
  final AppStatus status;

  const SplashLoadedState(this.status);

  @override
  List<Object?> get props => [status];
}

class SplashErrorState extends SplashState {
  final String message;

  const SplashErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
// Force re-analysis
