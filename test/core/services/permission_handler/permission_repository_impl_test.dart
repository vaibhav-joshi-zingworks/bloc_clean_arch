import 'package:bloc_clean_arch/core/services/permission_handler/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPermissionStrategyFactory extends Mock implements PermissionStrategyFactory {}
class MockPermissionInvoker extends Mock implements PermissionInvoker {}
class MockPermissionStrategy extends Mock implements PermissionStrategy {}

class FakePermissionCommand extends Fake implements PermissionCommand {
  @override
  Future<void> execute() async {}
}

void main() {
  setUpAll(() {
    // Required because mocktail uses `any()` on non-nullable `Permission` parameters.
    registerFallbackValue(Permission.camera);
    // Required because mocktail uses `any()` on `PermissionCommand` parameters.
    registerFallbackValue(FakePermissionCommand());
  });

  late PermissionRepositoryImpl repository;
  late MockPermissionStrategyFactory mockFactory;
  late MockPermissionInvoker mockInvoker;
  late MockPermissionStrategy mockStrategy;

  setUp(() {
    mockFactory = MockPermissionStrategyFactory();
    mockInvoker = MockPermissionInvoker();
    mockStrategy = MockPermissionStrategy();
    repository = PermissionRepositoryImpl(mockFactory, mockInvoker);
  });

  group('PermissionRepositoryImpl', () {
    test('requestPermission should call strategy.requestPermission', () async {
      when(() => mockFactory.createStrategy(any())).thenReturn(mockStrategy);
      when(() => mockStrategy.requestPermission(any())).thenAnswer((_) async => {});

      await repository.requestPermission(Permission.camera);

      verify(() => mockFactory.createStrategy(Permission.camera)).called(1);
      verify(() => mockStrategy.requestPermission(true)).called(1);
    });

    test('requestMultiplePermissions should add commands to invoker and execute', () async {
      when(() => mockFactory.createStrategy(any())).thenReturn(mockStrategy);
      when(() => mockInvoker.add(any())).thenReturn(null);
      when(() => mockInvoker.executeAll()).thenAnswer((_) async => {});

      await repository.requestMultiplePermissions([Permission.camera, Permission.location]);

      verify(() => mockInvoker.add(any())).called(2);
      verify(() => mockInvoker.executeAll()).called(1);
    });
  });
}
