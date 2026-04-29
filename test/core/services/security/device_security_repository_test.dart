import 'package:bloc_clean_arch/core/services/security/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceSecurityRepository extends Mock implements DeviceSecurityRepository {}

void main() {
  group('DeviceSecurityRepository', () {
    test('can be mocked', () {
      final repository = MockDeviceSecurityRepository();
      expect(repository, isA<DeviceSecurityRepository>());
    });
  });
}
