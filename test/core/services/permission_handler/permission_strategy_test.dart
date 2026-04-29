import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionStrategy extends Mock implements PermissionStrategy {}

void main() {
  group('PermissionStrategy', () {
    test('can be mocked', () {
      final strategy = MockPermissionStrategy();
      expect(strategy, isA<PermissionStrategy>());
    });
  });
}
