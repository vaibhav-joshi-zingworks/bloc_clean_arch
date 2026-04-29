import 'package:bloc_clean_arch/core/services/encryption/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EncryptionStrategyFactory', () {
    test('should create AesEncryptionStrategy for type aes', () {
      final strategy = EncryptionStrategyFactory.create(
        type: EncryptionType.aes,
        key: '01234567890123456789012345678901', // 32 chars
      );
      
      expect(strategy, isA<AesEncryptionStrategy>());
    });

    test('should throw UnimplementedError for rsa', () {
      expect(
        () => EncryptionStrategyFactory.create(type: EncryptionType.rsa, key: 'key'),
        throwsA(isA<UnimplementedError>()),
      );
    });
  });
}
