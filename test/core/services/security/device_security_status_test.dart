import 'package:bloc_clean_arch/core/services/security/domain/models/device_security_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeviceSecurityStatus', () {
    test('isUnsafe should be true if any check is true', () {
      const status = DeviceSecurityStatus(
        isRooted: true,
        isEmulator: false,
        isMockLocation: false,
        isDeveloperMode: false,
      );
      expect(status.isUnsafe, true);
    });

    test('isUnsafe should be false if all checks are false', () {
      const status = DeviceSecurityStatus(
        isRooted: false,
        isEmulator: false,
        isMockLocation: false,
        isDeveloperMode: false,
      );
      expect(status.isUnsafe, false);
    });

    test('toMap should return correct map', () {
      const status = DeviceSecurityStatus(
        isRooted: true,
        isEmulator: false,
        isMockLocation: true,
        isDeveloperMode: false,
      );
      final map = status.toMap();
      expect(map['rooted_or_jailbroken'], true);
      expect(map['emulator'], false);
      expect(map['mock_location'], true);
      expect(map['developer_mode'], false);
    });
  });
}
