import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionDialogHandler extends Mock implements PermissionDialogHandler {}

void main() {
  late CameraPermissionStrategy strategy;
  late MockPermissionDialogHandler mockDialogHandler;

  setUp(() {
    mockDialogHandler = MockPermissionDialogHandler();
    strategy = CameraPermissionStrategy(mockDialogHandler);
  });

  group('CameraPermissionStrategy', () {
    test('permission should be camera', () {
      expect(strategy.permission, Permission.camera);
    });

    test('permissionMessage should be correct', () {
      expect(strategy.permissionMessage, contains('camera'));
    });
    
    // Testing requestPermission is hard because Permission.camera.status 
    // is a static extension property that we can't easily mock.
    // Usually, we'd wrap Permission in an adapter if we wanted to test this logic.
  });
}
