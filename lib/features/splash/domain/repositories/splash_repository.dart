import '../entities/app_status.dart';

abstract class SplashRepository {
  Future<AppStatus> getAppStatus();
}