import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  group('NotificationRepository', () {
    test('can be mocked', () {
      final repository = MockNotificationRepository();
      expect(repository, isA<NotificationRepository>());
    });
  });
}
