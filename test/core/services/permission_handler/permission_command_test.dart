import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionCommand extends Mock implements PermissionCommand {}

void main() {
  group('PermissionCommand', () {
    test('can be mocked', () {
      final command = MockPermissionCommand();
      expect(command, isA<PermissionCommand>());
    });
  });
}
