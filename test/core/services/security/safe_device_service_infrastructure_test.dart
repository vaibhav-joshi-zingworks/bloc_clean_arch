import 'package:bloc_clean_arch/core/services/security/infrastructure/adapters/safe_device_adapter.dart';
import 'package:bloc_clean_arch/core/services/security/infrastructure/service/safe_device_service.dart';
import 'package:bloc_clean_arch/core/services/security/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSafeDeviceAdapter extends Mock implements SafeDeviceAdapter {}

void main() {
  late SafeDeviceService service;
  late MockSafeDeviceAdapter mockAdapter;

  setUp(() {
    mockAdapter = MockSafeDeviceAdapter();
    service = SafeDeviceService(mockAdapter);
  });

  group('SafeDeviceService (Infrastructure)', () {
    test('getSecurityStatus returns correct status and caches it', () async {
      when(() => mockAdapter.isJailBroken()).thenAnswer((_) async => true);
      when(() => mockAdapter.isRealDevice()).thenAnswer((_) async => false);
      when(() => mockAdapter.isMockLocation()).thenAnswer((_) async => true);
      when(() => mockAdapter.isDevModeEnabled()).thenAnswer((_) async => false);

      final status = await service.getSecurityStatus();

      expect(status.isRooted, true);
      expect(status.isEmulator, true);
      expect(status.isMockLocation, true);
      expect(status.isDeveloperMode, false);

      // Verify caching: second call shouldn't call adapter again
      await service.getSecurityStatus();
      verify(() => mockAdapter.isJailBroken()).called(1);
    });
  });
}
