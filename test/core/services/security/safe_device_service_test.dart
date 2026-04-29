import 'package:bloc_clean_arch/core/services/security/safe_device_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SafeDeviceService', () {
    test('getSecurityStatus returns map with default values', () {
      final status = SafeDeviceService.getSecurityStatus();
      expect(status, isA<Map<String, bool>>());
      expect(status.containsKey('Jail-Broken / Rooted'), true);
    });
  });
}
