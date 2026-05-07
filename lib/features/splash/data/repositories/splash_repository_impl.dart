import '../../domain/entities/app_status.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasource/splash_local_data_source.dart';

/// Concrete implementation of [SplashRepository].
/// 
/// Decides the initial app status based on local storage data.
class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource local;

  SplashRepositoryImpl(this.local);

  @override
  Future<AppStatus> getAppStatus() async {
    // 1. Check if it is the first launch
    final isFirst = await local.isFirstLaunch();
    if (isFirst) return AppStatus.firstLaunch;

    // 2. Check if a valid auth token exists
    final token = await local.getToken();
    if (token != null && token.isNotEmpty) {
      return AppStatus.authenticated;
    }

    // 3. Fallback to unauthenticated
    return AppStatus.unauthenticated;
  }
}
