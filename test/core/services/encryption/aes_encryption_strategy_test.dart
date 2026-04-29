import 'package:bloc_clean_arch/core/services/encryption/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AesEncryptionStrategy', () {
    const key = 'test_encryption_key';
    const plainText = 'Hello World';
    late AesEncryptionStrategy strategy;

    setUp(() {
      strategy = AesEncryptionStrategy(key);
    });

    test('should encrypt and decrypt correctly', () {
      final encrypted = strategy.encrypt(plainText);
      expect(encrypted, isNot(plainText));
      
      final decrypted = strategy.decrypt(encrypted);
      expect(decrypted, plainText);
    });

    test('should return different results for different plain texts', () {
      final encrypted1 = strategy.encrypt('text1');
      final encrypted2 = strategy.encrypt('text2');
      expect(encrypted1, isNot(encrypted2));
    });
  });
}
