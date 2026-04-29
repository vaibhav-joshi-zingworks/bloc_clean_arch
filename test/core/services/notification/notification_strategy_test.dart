import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationStrategy extends Mock implements NotificationStrategy {}

void main() {
  group('NotificationStrategy', () {
    test('can be mocked', () {
      final strategy = MockNotificationStrategy();
      expect(strategy, isA<NotificationStrategy>());
    });
  });
}
