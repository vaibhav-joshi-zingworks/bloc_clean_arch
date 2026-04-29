import 'package:bloc_clean_arch/core/services/encryption/enum/encryption_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EncryptionType', () {
    test('should have expected values', () {
      expect(EncryptionType.values, contains(EncryptionType.aes));
      expect(EncryptionType.values, contains(EncryptionType.rsa));
    });
  });
}
