import '../../services/encryption/xcore.dart';

/// Central manager for all data encryption and decryption tasks.
/// 
/// It acts as a singleton that holds an [IEncryptionStrategy] (like AES).
/// This manager is used by interceptors to secure network payloads.
class EncryptionManager {
  static EncryptionManager? _instance;
  final IEncryptionStrategy _strategy;

  EncryptionManager._internal(this._strategy);

  /// Factory constructor to initialize the manager with a specific [EncryptionType] and [key].
  factory EncryptionManager({
    required EncryptionType type, 
    required String key, 
    String? privateKey, 
    AESMode? aesMode, 
    String? padding
  }) {
    _instance ??= EncryptionManager._internal(
      EncryptionStrategyFactory.create(
        type: type, 
        key: key, 
        privateKey: privateKey, 
        aesMode: aesMode, 
        padding: padding
      ),
    );
    return _instance!;
  }

  /// Encrypts the provided [data] using the active strategy.
  String encrypt(String data) => _strategy.encrypt(data);
  
  /// Decrypts the [encryptedData] back to its original raw format.
  String decrypt(String encryptedData) => _strategy.decrypt(encryptedData);

  /// Utility to decrypt a specific key (e.g. for Razorpay or third-party SDKs) 
  /// using a one-off AES manager.
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
