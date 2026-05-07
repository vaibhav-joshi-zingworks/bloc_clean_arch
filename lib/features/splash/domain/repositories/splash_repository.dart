import '../entities/app_status.dart';

/// Abstract contract for retrieving initial application status.
abstract class SplashRepository {
  /// Determines if the user is authenticated, unauthenticated, or a new user.
  Future<AppStatus> getAppStatus();
}
