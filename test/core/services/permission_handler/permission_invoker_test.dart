import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PermissionInvoker', () {
    test('should be instantiable', () {
      final invoker = PermissionInvoker();
      expect(invoker, isA<PermissionInvoker>());
    });
  });
}
