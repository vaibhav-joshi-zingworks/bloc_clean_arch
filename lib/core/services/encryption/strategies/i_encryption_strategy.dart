abstract class IEncryptionStrategy {
  String encrypt(String data);
  String decrypt(String encryptedData);
}
