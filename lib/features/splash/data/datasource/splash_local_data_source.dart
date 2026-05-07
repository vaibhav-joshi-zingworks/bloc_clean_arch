import '../../../../core.dart';

/// Data source for accessing splash-related local data.
class SplashLocalDataSource {
  final StorageFacade storage;

  SplashLocalDataSource(this.storage);

  /// Retrieves the saved authentication token, if any.
  Future<String?> getToken() async {
    return storage.read('auth_token');
  }

  /// Checks if the app is being launched for the first time.
  Future<bool> isFirstLaunch() async {
    final value = await storage.read('first_launch');
    return value == null;
  }
}
