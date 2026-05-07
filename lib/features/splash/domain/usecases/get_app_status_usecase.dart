import '../entities/app_status.dart';
import '../repositories/splash_repository.dart';

/// Use case for retrieving the initial application status.
/// 
/// Helps in deciding the initial landing page of the application.
class GetAppStatusUseCase {
  final SplashRepository repository;

  GetAppStatusUseCase(this.repository);

  /// Executes the logic to fetch the current [AppStatus].
  Future<AppStatus> call() async {
    return repository.getAppStatus();
  }
}
