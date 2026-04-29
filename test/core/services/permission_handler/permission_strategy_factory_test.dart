import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionDialogHandler extends Mock implements PermissionDialogHandler {}

void main() {
  late PermissionStrategyFactory factory;
  late MockPermissionDialogHandler mockDialogHandler;

  setUp(() {
    mockDialogHandler = MockPermissionDialogHandler();
    factory = PermissionStrategyFactory(mockDialogHandler);
  });

  group('PermissionStrategyFactory', () {
    test('should create CameraPermissionStrategy for camera permission', () {
      final strategy = factory.createStrategy(Permission.camera);
      expect(strategy, isA<CameraPermissionStrategy>());
    });

    test('should return null for unsupported permission', () {
      final strategy = factory.createStrategy(Permission.location);
      expect(strategy, isNull);
    });
  });
}
