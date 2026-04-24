import '../xcore.dart';

class EncryptionStrategyFactory {
  static IEncryptionStrategy create({
    required EncryptionType type,
    required String key,
    String? privateKey, // for RSA
    AESMode? aesMode,
    String? padding,
  }) {
    switch (type) {
      case EncryptionType.aes:
        return AesEncryptionStrategy(key, mode: aesMode ?? AESMode.cbc, padding: padding);
    // case EncryptionType.rsa:
    //   if (privateKey == null) throw ArgumentError('Private key required for RSA');
    //   return RsaEncryptionStrategy(key, privateKey);
      case EncryptionType.rsa:
      // TODO: Handle this case.
        throw UnimplementedError();
    }
  }
}
