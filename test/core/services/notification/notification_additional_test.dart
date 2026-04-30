import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_test/flutter_test.dart';

class TestNotificationRateLimitStrategy implements NotificationRateLimitStrategy {
  @override
  Future<bool> canSend(String channelKey) async => true;

  @override
  Future<void> markSent(String channelKey) async {}
}

class TestNotificationRepository implements NotificationRepository {
  final Map<String, int> _store = {};

  @override
  Future<int?> getLastSent(String channelKey) async => _store[channelKey];

  @override
  Future<void> setLastSent(String channelKey, int timestamp) async {
    _store[channelKey] = timestamp;
  }
}

class TestNotificationStrategy implements NotificationStrategy {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> show({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    String? route,
    String? groupKey,
    String? bigPicture,
    NotificationLayout? layout,
  }) async {}

  @override
  Future<void> scheduleExact({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? route,
  }) async {}

  @override
  Future<void> showProgress({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required double progress,
  }) async {}

  @override
  Future<void> showChatMessage({
    required int id,
    required String title,
    required String body,
    required ChatType chatType,
    required String senderId,
    required String senderName,
    required String chatId,
    required String messageId,
    String? senderAvatar,
    String? groupKey,
    String? route,
  }) async {}

  @override
  Future<void> cancel(int id) async {}
}

void main() {
  group('NotificationChannels', () {
    test('should provide expected cooldowns and keys', () {
      expect(NotificationChannels.key(NotificationChannelType.general), 'general');
      expect(NotificationChannels.cooldownForKey('marketing'), 4);
      expect(NotificationChannels.cooldownForKey('unknown'), 0);
    });

    test('toAwesomeChannels should return all configured channels', () {
      final channels = NotificationChannels.toAwesomeChannels();

      expect(channels.length, NotificationChannels.channels.length);
      expect(channels.any((c) => c.channelKey == 'general'), isTrue);
    });
  });

  group('NotificationChannelConfig', () {
    test('should expose provided fields', () {
      const config = NotificationChannelConfig(
        key: 'k',
        name: 'name',
        description: 'desc',
        importance: NotificationImportance.High,
        cooldownHours: 2,
      );

      expect(config.key, 'k');
      expect(config.name, 'name');
      expect(config.description, 'desc');
      expect(config.importance, NotificationImportance.High);
      expect(config.cooldownHours, 2);
    });
  });

  group('DefaultNotificationChannelRegistry', () {
    test('getChannels should mirror NotificationChannels.toAwesomeChannels()', () {
      final registry = DefaultNotificationChannelRegistry();
      final channels = registry.getChannels();

      expect(channels.length, NotificationChannels.toAwesomeChannels().length);
    });
  });

  group('SharedPrefsNotificationRepository', () {
    setUpAll(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('setLastSent/getLastSent should roundtrip for a channel key', () async {
      final repo = SharedPrefsNotificationRepository();

      expect(await repo.getLastSent('general'), isNull);

      await repo.setLastSent('general', 123);
      expect(await repo.getLastSent('general'), 123);
    });
  });

  group('Notification interfaces', () {
    test('NotificationStrategy/RateLimitStrategy/Repository should be implementable', () async {
      final strategy = TestNotificationStrategy();
      final repo = TestNotificationRepository();
      final rateLimiter = TestNotificationRateLimitStrategy();

      await strategy.initialize();
      await strategy.show(
        id: 1,
        channelKey: 'general',
        title: 'title',
        body: 'body',
      );

      expect(await repo.getLastSent('general'), isNull);
      await repo.setLastSent('general', 50);
      expect(await repo.getLastSent('general'), 50);

      expect(await rateLimiter.canSend('general'), isTrue);
      await rateLimiter.markSent('general');

      await strategy.cancel(1);
    });
  });

  group('Plugin adapter/event handler smoke signatures', () {
    test('AwesomeNotificationsAdapter should expose expected method signatures', () {
      final adapter = AwesomeNotificationsAdapter();

      expect(adapter.initialize, isA<Future<void> Function(List<NotificationChannel>)>());
      expect(adapter.isAllowed, isA<Future<bool> Function()>());
      expect(adapter.requestPermission, isA<Future<void> Function()>());
    });

    test('AwesomeNotificationEventHandler should expose entrypoint signatures', () {
      expect(
        AwesomeNotificationEventHandler.onCreated,
        isA<Future<void> Function(ReceivedNotification)>(),
      );
      expect(
        AwesomeNotificationEventHandler.onActionReceived,
        isA<Future<void> Function(ReceivedAction)>(),
      );
    });
  });
}

