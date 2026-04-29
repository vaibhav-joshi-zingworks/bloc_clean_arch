import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/adapters/device_info_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDeviceInfoAdapter extends Mock implements DeviceInfoAdapter {}

void main() {
  group('DeviceInfoAdapter', () {
    test('can be mocked', () {
      final adapter = MockDeviceInfoAdapter();
      expect(adapter, isA<DeviceInfoAdapter>());
    });
  });
}
