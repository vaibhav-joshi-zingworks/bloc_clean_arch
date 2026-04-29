import 'package:bloc_clean_arch/core/services/notification/infrastructure/strategies/awesome_notification_strategy.dart';
import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class MockNotificationRateLimitStrategy extends Mock implements NotificationRateLimitStrategy {}
class MockAwesomeNotificationsAdapter extends Mock implements AwesomeNotificationsAdapter {}
class MockNotificationChannelRegistry extends Mock implements NotificationChannelRegistry {}

void main() {
  setUpAll(() {
    // Required because mocktail uses `any()` on the non-nullable `NotificationContent` param.
    registerFallbackValue(NotificationContent(id: 0, channelKey: 'test_channel'));
  });

  late AwesomeNotificationStrategy strategy;
  late MockNotificationRateLimitStrategy mockRateLimit;
  late MockAwesomeNotificationsAdapter mockAdapter;
  late MockNotificationChannelRegistry mockChannelRegistry;

  setUp(() {
    mockRateLimit = MockNotificationRateLimitStrategy();
    mockAdapter = MockAwesomeNotificationsAdapter();
    mockChannelRegistry = MockNotificationChannelRegistry();
    strategy = AwesomeNotificationStrategy(
      rateLimitStrategy: mockRateLimit,
      adapter: mockAdapter,
      channelRegistry: mockChannelRegistry,
    );

    when(() => mockChannelRegistry.getChannels()).thenReturn([]);
    when(() => mockAdapter.initialize(any())).thenAnswer((_) async => true);
    when(() => mockAdapter.setListeners(
      onAction: any(named: 'onAction'),
      onCreated: any(named: 'onCreated'),
      onDisplayed: any(named: 'onDisplayed'),
      onDismiss: any(named: 'onDismiss'),
    )).thenReturn(null);
    when(() => mockAdapter.isAllowed()).thenAnswer((_) async => true);
  });

  group('AwesomeNotificationStrategy', () {
    test('show should call create on adapter if rate limit allowed', () async {
      when(() => mockRateLimit.canSend(any())).thenAnswer((_) async => true);
      when(() => mockRateLimit.markSent(any())).thenAnswer((_) async => {});
      when(() => mockAdapter.create(any(), actionButtons: any(named: 'actionButtons'), schedule: any(named: 'schedule')))
          .thenAnswer((_) async => true);

      await strategy.show(id: 1, channelKey: 'key', title: 'title', body: 'body');

      verify(() => mockAdapter.create(any())).called(1);
      verify(() => mockRateLimit.markSent('key')).called(1);
    });

    test('show should not call create if rate limit exceeded', () async {
      when(() => mockRateLimit.canSend(any())).thenAnswer((_) async => false);

      await strategy.show(id: 1, channelKey: 'key', title: 'title', body: 'body');

      verifyNever(() => mockAdapter.create(any()));
    });
  });
}
