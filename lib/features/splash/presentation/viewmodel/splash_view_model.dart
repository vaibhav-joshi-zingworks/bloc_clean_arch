import '../bloc/splash_cubit.dart';

class SplashViewModel {
  final SplashCubit cubit;

  SplashViewModel(this.cubit);

  void initialize() => cubit.init();
}