import '../xcore.dart';

/// Factory for creating [IEncryptionStrategy] instances based on [EncryptionType].
class EncryptionStrategyFactory {
  /// Creates and configures an encryption strategy.
  static IEncryptionStrategy create({
    required EncryptionType type,
    required String key,
    String? privateKey, // Required if using RSA
    AESMode? aesMode,
    String? padding,
  }) {
    switch (type) {
      case EncryptionType.aes:
        // Returns the AES implementation with provided or default configuration
        return AesEncryptionStrategy(
          key,
          mode: aesMode ?? AESMode.cbc,
          padding: padding ?? 'PKCS7',
        );
      case EncryptionType.rsa:
        // RSA implementation placeholder
        throw UnimplementedError('RSA encryption is not yet implemented');
    }
  }
}
