import 'package:bloc_clean_arch/core/design/device_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DeviceType enum should have expected values', () {
    expect(DeviceType.values, contains(DeviceType.mobile));
    expect(DeviceType.values, contains(DeviceType.tablet));
    expect(DeviceType.values, contains(DeviceType.desktop));
  });
}
