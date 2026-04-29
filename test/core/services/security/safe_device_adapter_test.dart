import 'package:bloc_clean_arch/core/services/security/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SafeDeviceAdapter', () {
    test('should be instantiable', () {
      final adapter = SafeDeviceAdapter();
      expect(adapter, isA<SafeDeviceAdapter>());
    });
  });
}
