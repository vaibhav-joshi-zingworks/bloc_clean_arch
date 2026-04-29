import 'package:bloc_clean_arch/core/services/app_device_info/domain/repositories/device_info_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceInfoRepository extends Mock implements DeviceInfoRepository {}

void main() {
  group('DeviceInfoRepository', () {
    test('can be mocked', () {
      final repository = MockDeviceInfoRepository();
      expect(repository, isA<DeviceInfoRepository>());
    });
  });
}
