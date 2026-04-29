import 'package:bloc_clean_arch/core/services/encryption/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

class TestEncryptionStrategy implements IEncryptionStrategy {
  @override
  String encrypt(String data) => data.split('').reversed.join();

  @override
  String decrypt(String encryptedData) => encryptedData.split('').reversed.join();
}

void main() {
  group('EncryptionType', () {
    test('should include aes and rsa', () {
      expect(EncryptionType.values, containsAll(<EncryptionType>[EncryptionType.aes, EncryptionType.rsa]));
      expect(EncryptionType.aes, isA<EncryptionType>());
      expect(EncryptionType.rsa, isA<EncryptionType>());
    });
  });

  group('IEncryptionStrategy', () {
    test('should be implementable and support encrypt/decrypt', () {
      final strategy = TestEncryptionStrategy();

      const plainText = 'hello';
      final encrypted = strategy.encrypt(plainText);
      expect(encrypted, isNot(plainText));

      final decrypted = strategy.decrypt(encrypted);
      expect(decrypted, plainText);
    });
  });
}

