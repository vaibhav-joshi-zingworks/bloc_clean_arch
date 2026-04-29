import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PermissionDialogHandler', () {
    test('should be instantiable', () {
      final handler = PermissionDialogHandler();
      expect(handler, isA<PermissionDialogHandler>());
    });
  });
}
