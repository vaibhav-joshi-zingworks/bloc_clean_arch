
import '../../../core.dart';
import '../../services/encryption/xcore.dart';

/// Interceptor that handles transparent end-to-end encryption for API payloads.
/// 
/// It automatically encrypts request data for mutation methods (POST, PUT, PATCH)
/// and decrypts incoming response data if the server returns an encrypted payload.
class PayloadInterceptor extends Interceptor {
  final EncryptionManager encryptionManager;

  PayloadInterceptor(this.encryptionManager);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Determine if the request payload should be encrypted based on method and data availability
    if (_shouldEncrypt(options)) {
      try {
        final data = options.data;

        if (data != null) {
          // Serialize data to JSON if it's a Map, then encrypt the string
          final raw = data is Map ? jsonEncode(data) : data.toString();
          final encrypted = encryptionManager.encrypt(raw);

          // Replace raw data with the encrypted string
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
    // Determine if the response payload should be decrypted
    if (_shouldDecrypt(response)) {
      try {
        final data = response.data;

        // By convention, encrypted data is usually wrapped in a 'data' key
        if (data is Map && data.containsKey('data')) {
          final encrypted = data['data'];

          if (encrypted is String && encrypted.isNotEmpty) {
            final decrypted = encryptionManager.decrypt(encrypted);
            // Replace encrypted string with the parsed JSON object
            data['data'] = jsonDecode(decrypted);
          }
        }
      } catch (e) {
        LoggerService.talker.error('❌ Decryption failed: $e');
      }
    }

    handler.next(response);
  }

  /// Internal logic to decide if a request requires encryption.
  bool _shouldEncrypt(RequestOptions options) {
    return (options.method == 'POST' ||
        options.method == 'PUT' ||
        options.method == 'PATCH') &&
        options.data != null &&
        (options.extra['isRetry'] != true);
  }

  /// Internal logic to decide if a response requires decryption.
  bool _shouldDecrypt(Response response) {
    return response.data != null &&
        response.data.toString().trim().isNotEmpty;
  }
}
