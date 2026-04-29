import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionRepository extends Mock implements PermissionRepository {}

void main() {
  group('PermissionRepository', () {
    test('can be mocked', () {
      final repository = MockPermissionRepository();
      expect(repository, isA<PermissionRepository>());
    });
  });
}
