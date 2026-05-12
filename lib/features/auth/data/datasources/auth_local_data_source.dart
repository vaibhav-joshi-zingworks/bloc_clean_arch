import '../../../../app/storage_keys.dart';
import '../../../../core.dart';
import '../../domain/entities/auth_session_entity.dart';

/// Local persistence for authentication session data.
class AuthLocalDataSource {
  final StorageFacade _storage;

  AuthLocalDataSource(this._storage);

  Future<void> saveSession(AuthSessionEntity session) async {
    await _storage.save(
      key: AuthStorageKeys.accessToken,
      value: session.accessToken,
    );

    final refreshToken = session.refreshToken;
    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _storage.save(
        key: AuthStorageKeys.refreshToken,
        value: refreshToken,
      );
    }

    await _storage.save(
      key: AuthStorageKeys.userId,
      value: session.user.id.toString(),
    );
  }

  Future<String?> getAccessToken() {
    return _storage.read(AuthStorageKeys.accessToken);
  }

  Future<void> clearSession() async {
    await Future.wait([
      _storage.remove(AuthStorageKeys.accessToken),
      _storage.remove(AuthStorageKeys.refreshToken),
      _storage.remove(AuthStorageKeys.userId),
    ]);
  }
}
