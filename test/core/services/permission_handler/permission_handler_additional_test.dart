import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionCommand extends Mock implements PermissionCommand {}

class TestPermissionStrategy implements PermissionStrategy {
  @override
  Permission get permission => Permission.notification;

  @override
  String get permissionMessage => 'test message';

  @override
  Future<void> requestPermission(bool showSettingsDialog) async {}
}

class TestPermissionRepository implements PermissionRepository {
  bool _granted = false;

  @override
  Future<void> requestPermission(Permission permission, {bool showDialog = true}) async {
    _granted = true;
  }

  @override
  Future<void> requestMultiplePermissions(List<Permission> permissions) async {
    _granted = true;
  }

  @override
  Future<bool> isPermissionGranted(Permission permission) async => _granted;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NotificationPermissionStrategy', () {
    test('permission and permissionMessage should match', () {
      final strategy = NotificationPermissionStrategy(PermissionDialogHandler());

      expect(strategy.permission, Permission.notification);
      expect(strategy.permissionMessage.toLowerCase(), contains('notifications'));
    });
  });

  group('PermissionInvoker', () {
    test('executeAll should execute queued commands and clear them', () async {
      final invoker = PermissionInvoker();

      final cmd1 = MockPermissionCommand();
      final cmd2 = MockPermissionCommand();

      when(() => cmd1.execute()).thenAnswer((_) async {});
      when(() => cmd2.execute()).thenAnswer((_) async {});

      invoker.add(cmd1);
      await invoker.executeAll();

      invoker.add(cmd2);
      await invoker.executeAll();

      verify(() => cmd1.execute()).called(1);
      verify(() => cmd2.execute()).called(1);
    });
  });

  group('PermissionDialogHandler', () {
    test('showOpenSettingsDialog should not throw when navigator context is null', () async {
      final handler = PermissionDialogHandler();

      await expectLater(
        handler.showOpenSettingsDialog(Permission.camera, 'message'),
        completes,
      );
    });
  });

  group('Permission interfaces', () {
    test('PermissionStrategy/Repository should be implementable', () async {
      final strategy = TestPermissionStrategy();
      final repo = TestPermissionRepository();

      expect(strategy.permission, Permission.notification);
      await strategy.requestPermission(true);

      expect(await repo.isPermissionGranted(Permission.notification), isFalse);
      await repo.requestPermission(Permission.notification);
      expect(await repo.isPermissionGranted(Permission.notification), isTrue);
    });
  });
}

