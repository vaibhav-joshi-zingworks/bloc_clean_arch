import '../../services/encryption/xcore.dart';

class EncryptionManager {
  static EncryptionManager? _instance;
  final IEncryptionStrategy _strategy;

  EncryptionManager._internal(this._strategy);

  factory EncryptionManager({required EncryptionType type, required String key, String? privateKey, AESMode? aesMode, String? padding}) {
    _instance ??= EncryptionManager._internal(
      EncryptionStrategyFactory.create(type: type, key: key, privateKey: privateKey, aesMode: aesMode, padding: padding),
    );
    return _instance!;
  }

  String encrypt(String data) => _strategy.encrypt(data);
  String decrypt(String encryptedData) => _strategy.decrypt(encryptedData);

  /// Optional helper for Razorpay key
  static String? decryptedKey(String? encryptedKey, String encryptionKey) {
    if (encryptedKey == null || encryptedKey.trim().isEmpty) return null;
    final manager = EncryptionManager(type: EncryptionType.aes, key: encryptionKey);
    try {
      return manager.decrypt(encryptedKey);
    } catch (_) {
      return '';
    }
  }
}
