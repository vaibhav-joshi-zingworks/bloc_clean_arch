import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStorageFacade extends Mock implements StorageFacade {}

void main() {
  group('SharedPrefsNotificationRepository', () {
    test('should be instantiable', () {
      final repository = SharedPrefsNotificationRepository();
      expect(repository, isA<SharedPrefsNotificationRepository>());
    });
  });
}
