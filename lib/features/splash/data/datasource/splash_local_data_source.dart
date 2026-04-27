import '../../../../core.dart';

class SplashLocalDataSource {
  final StorageFacade storage;

  SplashLocalDataSource(this.storage);

  Future<String?> getToken() async {
    return storage.read('auth_token');
  }

  Future<bool> isFirstLaunch() async {
    final value = await storage.read('first_launch');
    return value == null;
  }
}