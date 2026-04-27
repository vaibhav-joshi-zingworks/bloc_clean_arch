import '../entities/app_status.dart';
import '../repositories/splash_repository.dart';

class GetAppStatusUseCase {
  final SplashRepository repository;

  GetAppStatusUseCase(this.repository);

  Future<AppStatus> call() async {
    return repository.getAppStatus();
  }
}