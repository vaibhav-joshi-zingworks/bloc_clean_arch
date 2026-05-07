import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import '../xcore.dart';

/// Concrete implementation of [IEncryptionStrategy] using the AES algorithm.
/// 
/// It uses SHA256 to hash the provided key to a standard 256-bit length.
/// Supports CBC (default) and ECB modes with configurable padding.
class AesEncryptionStrategy implements IEncryptionStrategy {
  final Key _key;
  final AESMode _mode;
  final String? _padding;

  AesEncryptionStrategy(String encryptionKey, {AESMode mode = AESMode.cbc, String? padding = 'PKCS7'})
      : _key = Key(Uint8List.fromList(sha256.convert(utf8.encode(encryptionKey)).bytes)),
        _mode = mode,
        _padding = padding;

  @override
  String encrypt(String data) {
    // Generate an IV (Initialization Vector) if not in ECB mode
    final iv = _mode == AESMode.ecb ? IV.fromLength(0) : IV.fromLength(16);
    final encrypter = Encrypter(AES(_key, mode: _mode, padding: _padding));
    final encrypted = encrypter.encrypt(data, iv: iv);
    
    // Combine IV and encrypted bytes before base64 encoding to allow decryption
    final combined = iv.bytes + encrypted.bytes;
    return base64Encode(combined);
  }

  @override
  String decrypt(String encryptedData) {
    final decoded = base64Decode(encryptedData);
    final ivLength = _mode == AESMode.ecb ? 0 : 16;
    
    // Extract the IV from the start of the decoded bytes
    final iv = IV(decoded.sublist(0, ivLength));
    final encryptedBytes = Encrypted(decoded.sublist(ivLength));
    final encrypter = Encrypter(AES(_key, mode: _mode, padding: _padding));

    return encrypter.decrypt(encryptedBytes, iv: iv);
  }
}
