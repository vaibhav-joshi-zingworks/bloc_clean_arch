import 'package:bloc_clean_arch/core/services/security/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

class TestDeviceSecurityRepository implements DeviceSecurityRepository {
  TestDeviceSecurityRepository(this._status);
  final DeviceSecurityStatus _status;

  @override
  Future<DeviceSecurityStatus> getSecurityStatus() async => _status;
}

void main() {
  group('SafeDeviceAdapter', () {
    test('should expose methods returning Future<bool> (smoke signature checks)', () {
      final adapter = SafeDeviceAdapter();

      expect(adapter.isJailBroken, isA<Future<bool> Function()>());
      expect(adapter.isRealDevice, isA<Future<bool> Function()>());
      expect(adapter.isMockLocation, isA<Future<bool> Function()>());
      expect(adapter.isDevModeEnabled, isA<Future<bool> Function()>());
    });
  });

  group('DeviceSecurityRepository', () {
    test('should be implementable and return a DeviceSecurityStatus', () async {
      const status = DeviceSecurityStatus(
        isRooted: false,
        isEmulator: false,
        isMockLocation: false,
        isDeveloperMode: false,
      );

      final repo = TestDeviceSecurityRepository(status);
      expect(await repo.getSecurityStatus(), status);
    });
  });
}

