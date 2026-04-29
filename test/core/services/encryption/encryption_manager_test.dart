import 'package:bloc_clean_arch/core/services/encryption/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EncryptionManager', () {
    test('encrypt/decrypt should roundtrip for aes', () {
      const encryptionKey = 'test_encryption_key';
      const plainText = 'Hello World';

      final manager = EncryptionManager(
        type: EncryptionType.aes,
        key: encryptionKey,
      );

      final encrypted = manager.encrypt(plainText);
      expect(encrypted, isNot(plainText));

      final decrypted = manager.decrypt(encrypted);
      expect(decrypted, plainText);
    });
    
    test('decryptedKey should return null if key is null or empty', () {
      expect(EncryptionManager.decryptedKey(null, 'key'), isNull);
      expect(EncryptionManager.decryptedKey('', 'key'), isNull);
    });
  });
}
