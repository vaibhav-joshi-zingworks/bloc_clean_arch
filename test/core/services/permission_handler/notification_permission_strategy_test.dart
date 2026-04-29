import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionDialogHandler extends Mock implements PermissionDialogHandler {}

void main() {
  late NotificationPermissionStrategy strategy;
  late MockPermissionDialogHandler mockDialogHandler;

  setUp(() {
    mockDialogHandler = MockPermissionDialogHandler();
    strategy = NotificationPermissionStrategy(mockDialogHandler);
  });

  group('NotificationPermissionStrategy', () {
    test('permission should be notification', () {
      expect(strategy.permission, Permission.notification);
    });
  });
}
