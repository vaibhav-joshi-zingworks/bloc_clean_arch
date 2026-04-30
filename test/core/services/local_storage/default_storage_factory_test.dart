import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late DefaultStorageStrategyFactory factory;

  setUp(() {
    factory = DefaultStorageStrategyFactory();
    SharedPreferences.setMockInitialValues({});
  });

  group('DefaultStorageStrategyFactory', () {
    test('should create sharedPreferences engine', () async {
      final facade = await factory.create(StorageEngine.sharedPreferences);
      expect(facade, isA<StrategyBasedStorageFacade>());
    });

    test('should create secureStorage engine', () async {
      final facade = await factory.create(StorageEngine.secureStorage);
      expect(facade, isA<StrategyBasedStorageFacade>());
    });

    test('should throw for unimplemented engine', () {
      expect(() => factory.create(StorageEngine.hive), throwsA(isA<UnimplementedError>()));
    });
  });
}
