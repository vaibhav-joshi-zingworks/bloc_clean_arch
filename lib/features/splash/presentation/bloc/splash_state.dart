import '../../domain/entities/app_status.dart';

class SplashState {
  final bool isLoading;
  final AppStatus? status;

  const SplashState({
    this.isLoading = false,
    this.status,
  });

  SplashState copyWith({
    bool? isLoading,
    AppStatus? status,
  }) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
    );
  }
}