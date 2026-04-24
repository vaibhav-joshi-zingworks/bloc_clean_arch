
import '../../../core.dart';
import '../../services/encryption/xcore.dart';


class PayloadInterceptor extends Interceptor {
  final EncryptionManager encryptionManager;

  PayloadInterceptor(this.encryptionManager);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // if (options.path == UrlEndPoints.versionApi) {
    //   return handler.next(options);
    // }

    if (_shouldEncrypt(options)) {
      try {
        final data = options.data;

        if (data != null) {
          final raw = data is Map ? jsonEncode(data) : data.toString();
          final encrypted = encryptionManager.encrypt(raw);

          options.data = encrypted;
        }
      } catch (e) {
        LoggerService.talker.error('❌ Encryption failed: $e');
      }
    }

    handler.next(options);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) async {
    // if (response.requestOptions.path == UrlEndPoints.versionApi) {
    //   return handler.next(response);
    // }

    if (_shouldDecrypt(response)) {
      try {
        final data = response.data;

        if (data is Map && data.containsKey('data')) {
          final encrypted = data['data'];

          if (encrypted is String && encrypted.isNotEmpty) {
            final decrypted = encryptionManager.decrypt(encrypted);
            data['data'] = jsonDecode(decrypted);
          }
        }
      } catch (e) {
        LoggerService.talker.error('❌ Decryption failed: $e');
      }
    }

    handler.next(response);
  }

  bool _shouldEncrypt(RequestOptions options) {
    return (options.method == 'POST' ||
        options.method == 'PUT' ||
        options.method == 'PATCH') &&
        options.data != null &&
        (options.extra['isRetry'] != true);
  }

  bool _shouldDecrypt(Response response) {
    return response.data != null &&
        response.data.toString().trim().isNotEmpty;
  }
}