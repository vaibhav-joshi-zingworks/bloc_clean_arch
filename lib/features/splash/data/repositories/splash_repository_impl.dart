import '../../domain/entities/app_status.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasource/splash_local_data_source.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource local;

  SplashRepositoryImpl(this.local);

  @override
  Future<AppStatus> getAppStatus() async {
    final isFirst = await local.isFirstLaunch();

    if (isFirst) return AppStatus.firstLaunch;

    final token = await local.getToken();

    if (token != null && token.isNotEmpty) {
      return AppStatus.authenticated;
    }

    return AppStatus.unauthenticated;
  }
}