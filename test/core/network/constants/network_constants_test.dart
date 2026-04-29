import 'package:bloc_clean_arch/core/network/constants/flags.dart';
import 'package:bloc_clean_arch/core/network/constants/network_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Network Constants', () {
    test('Flags should have correct values', () {
      expect(Flags.token, 'token');
      expect(Flags.refreshToken, 'refreshToken');
    });

    test('HeaderKey should have correct values', () {
      expect(HeaderKey.authorization, 'authorization');
      expect(HeaderKey.header['Accept'], 'application/json');
    });
  });
}
