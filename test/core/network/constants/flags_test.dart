import 'package:bloc_clean_arch/core/network/constants/flags.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Flags', () {
    test('should have expected static constant values', () {
      expect(Flags.permission, "permission");
      expect(Flags.onboarding, "onboarding");
      expect(Flags.token, "token");
      expect(Flags.refreshToken, "refreshToken");
      expect(Flags.fcmToken, "fcmToken");
      expect(Flags.userId, "userId");
      expect(Flags.isRegistered, "isRegistered");
    });
  });
}
