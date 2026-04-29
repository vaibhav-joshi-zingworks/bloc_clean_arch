import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/local_storage/infrastructure/factories/default_storage_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
