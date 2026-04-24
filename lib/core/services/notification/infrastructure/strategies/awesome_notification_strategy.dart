import '/core.dart';

class AwesomeNotificationStrategy implements NotificationStrategy {
  final NotificationRateLimitStrategy rateLimitStrategy;
  final AwesomeNotificationsAdapter adapter;
  final NotificationChannelRegistry channelRegistry;

  bool _initialized = false;
  Future<void>? _initializingFuture;

  AwesomeNotificationStrategy({required this.rateLimitStrategy, required this.adapter, required this.channelRegistry});

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    // Prevent multiple parallel initializations
    if (_initializingFuture != null) {
      return _initializingFuture!;
    }

    _initializingFuture = _performInitialization();
    await _initializingFuture;

    _initialized = true;
    _initializingFuture = null;
  }

  Future<void> _performInitialization() async {
    await adapter.initialize(channelRegistry.getChannels());

    adapter.setListeners(
      onAction: AwesomeNotificationEventHandler.onActionReceived,
      onCreated: AwesomeNotificationEventHandler.onCreated,
      onDisplayed: AwesomeNotificationEventHandler.onDisplayed,
      onDismiss: AwesomeNotificationEventHandler.onDismiss,
    );

    if (kIsWeb) return;
    if (Platform.isAndroid || Platform.isIOS) {
      final allowed = await adapter.isAllowed();
      if (!allowed) {
        await adapter.requestPermission();
      }
    }
  }

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
    double? progress,
  }) async {
    await initialize();

    if (!await rateLimitStrategy.canSend(channelKey)) return;

    await adapter.create(
      NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        groupKey: groupKey,
        bigPicture: bigPicture,
        notificationLayout: layout ?? NotificationLayout.Default,
        payload: route != null ? {"route": route} : null,
        progress: progress,
      ),
    );

    await rateLimitStrategy.markSent(channelKey);
  }

  @override
  Future<void> scheduleExact({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? route,
  }) async {
    await initialize();
    if (!await rateLimitStrategy.canSend(channelKey)) return;

    await adapter.create(
      NotificationContent(id: id, channelKey: channelKey, title: title, body: body, payload: route != null ? {"route": route} : null),
      schedule: NotificationCalendar.fromDate(date: scheduledDate, preciseAlarm: true),
    );
    await rateLimitStrategy.markSent(channelKey);
  }

  @override
  Future<void> showProgress({
    required int id,
    required String channelKey,
    required String title,
    required String body,
    required double progress,
  }) async {
    await initialize();
    if (!await rateLimitStrategy.canSend(channelKey)) return;
    await adapter.create(
      NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.ProgressBar,
        progress: progress,
      ),
    );
    await rateLimitStrategy.markSent(channelKey);
  }

  @override
  Future<void> cancel(int id) async {
    await adapter.cancel(id);
  }

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
  }) async {
    await initialize();

    final channelKey = chatType == ChatType.single
        ? NotificationChannels.key(NotificationChannelType.chat)
        : NotificationChannels.key(NotificationChannelType.groupChat);

    if (!await rateLimitStrategy.canSend(channelKey)) return;

    await adapter.create(
      NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        largeIcon: senderAvatar,
        groupKey: chatType == ChatType.group ? groupKey : null,
        payload: route != null ? {"route": route, "messageId": messageId} : null,
        notificationLayout: chatType == ChatType.group ? NotificationLayout.MessagingGroup : NotificationLayout.Messaging,
      ),
      actionButtons: [
        NotificationActionButton(key: 'REPLY', label: 'Reply', requireInputText: true),
        NotificationActionButton(key: 'MARK_READ', label: 'Mark as Read', actionType: ActionType.DismissAction),
      ],
    );

    await rateLimitStrategy.markSent(channelKey);
  }
}
