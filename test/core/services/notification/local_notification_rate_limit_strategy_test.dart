import 'package:bloc_clean_arch/core/services/notification/infrastructure/strategies/local_notification_rate_limit_strategy.dart';
import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock implements NotificationRepository {}

void main() {
  late LocalNotificationRateLimitStrategy strategy;
  late MockNotificationRepository mockRepository;

  setUp(() {
    mockRepository = MockNotificationRepository();
    strategy = LocalNotificationRateLimitStrategy(repository: mockRepository);
  });

  group('LocalNotificationRateLimitStrategy', () {
    test('canSend should return true if never sent', () async {
      when(() => mockRepository.getLastSent(any())).thenAnswer((_) async => null);
      final result = await strategy.canSend('test_channel');
      expect(result, true);
    });

    test('markSent should call repository.setLastSent', () async {
      when(() => mockRepository.setLastSent(any(), any())).thenAnswer((_) async => {});
      await strategy.markSent('test_channel');
      verify(() => mockRepository.setLastSent('test_channel', any())).called(1);
    });
  });
}
