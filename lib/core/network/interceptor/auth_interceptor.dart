import 'dart:developer';

import '../../../core.dart';

class AuthInterceptor extends Interceptor {
  final StorageFacade _storage;

  AuthInterceptor(this._storage);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      final results = await Future.wait([
        _storage.read(Flags.token),
        _storage.read(Flags.refreshToken),
      ]);

      final token = results[0];
      final refreshToken = results[1];

      // ✅ Use actual token
      if (token?.isNotEmpty == true) {
        options.headers[HeaderKey.authorization] = 'Bearer $token';
      }

      if (refreshToken?.isNotEmpty == true) {
        options.headers[HeaderKey.refreshToken] = refreshToken;
      }
    } catch (e) {
      if (kDebugMode) {
        log('AuthInterceptor error: $e');
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // TODO: refresh token logic
    }
    handler.next(err);
  }
}