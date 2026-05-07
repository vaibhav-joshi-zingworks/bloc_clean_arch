import 'dart:developer';

import '../../../core.dart';

/// Interceptor responsible for adding authentication tokens to outgoing requests.
/// 
/// It retrieves the stored Access Token and Refresh Token from the [StorageFacade]
/// and injects them into the request headers.
class AuthInterceptor extends Interceptor {
  final StorageFacade _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // Fetch tokens from local storage concurrently
      final results = await Future.wait([
        _storage.read(Flags.token),
        _storage.read(Flags.refreshToken),
      ]);

      final token = results[0];
      final refreshToken = results[1];

      // Inject Access Token as a Bearer token if available
      if (token?.isNotEmpty == true) {
        options.headers[HeaderKey.authorization] = 'Bearer $token';
      }

      // Inject Refresh Token if available
      if (refreshToken?.isNotEmpty == true) {
        options.headers[HeaderKey.refreshToken] = refreshToken;
      }
    } catch (e) {
      if (kDebugMode) {
        log('AuthInterceptor error: $e');
      }
    }

    // Continue with the request
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Intercept 401 Unauthorized errors to handle session expiry or token refresh
    if (err.response?.statusCode == 401) {
      // TODO: Implement refresh token logic here to automatically renew expired sessions
    }
    handler.next(err);
  }
}
