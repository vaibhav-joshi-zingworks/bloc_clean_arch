/// Interface for data encryption and decryption strategies.
abstract class IEncryptionStrategy {
  /// Encrypts raw [data] into a secure format.
  String encrypt(String data);
  
  /// Decrypts [encryptedData] back to its original raw string format.
  String decrypt(String encryptedData);
}
