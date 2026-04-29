import 'package:bloc_clean_arch/core/services/messaging/domain/messaging_service.dart';
import 'package:flutter_test/flutter_test.dart';

class TestMessagingService implements MessagingService {
  bool _initialized = false;
  String? _token;

  @override
  Future<void> initialize() async {
    _initialized = true;
    _token = 'token_123';
  }

  @override
  Future<String?> getToken() async => _token;

  @override
  Future<void> subscribeToTopic(String topic) async {
    // no-op for test
    expect(topic, isNotEmpty);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    // no-op for test
    expect(topic, isNotEmpty);
  }
}

void main() {
  group('MessagingService', () {
    test('can be implemented and its async methods complete', () async {
      final service = TestMessagingService();

      await service.initialize();
      expect(await service.getToken(), 'token_123');

      await service.subscribeToTopic('updates');
      await service.unsubscribeFromTopic('updates');
    });
  });
}

