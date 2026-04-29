import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureStorageStrategy strategy;
  late MockFlutterSecureStorage mockSecureStorage;

  setUp(() {
    mockSecureStorage = MockFlutterSecureStorage();
    strategy = SecureStorageStrategy(mockSecureStorage);
  });

  group('SecureStorageStrategy', () {
    test('write should call FlutterSecureStorage.write', () async {
      when(() => mockSecureStorage.write(key: any(named: 'key'), value: any(named: 'value')))
          .thenAnswer((_) async => {});
      
      await strategy.write('key', 'value');
      
      verify(() => mockSecureStorage.write(key: 'key', value: 'value')).called(1);
    });

    test('read should call FlutterSecureStorage.read', () async {
      when(() => mockSecureStorage.read(key: any(named: 'key'))).thenAnswer((_) async => 'value');
      
      final result = await strategy.read('key');
      
      expect(result, 'value');
      verify(() => mockSecureStorage.read(key: 'key')).called(1);
    });

    test('delete should call FlutterSecureStorage.delete', () async {
      when(() => mockSecureStorage.delete(key: any(named: 'key'))).thenAnswer((_) async => {});
      
      await strategy.delete('key');
      
      verify(() => mockSecureStorage.delete(key: 'key')).called(1);
    });

    test('clear should call FlutterSecureStorage.deleteAll', () async {
      when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async => {});
      
      await strategy.clear();
      
      verify(() => mockSecureStorage.deleteAll()).called(1);
    });
  });
}
