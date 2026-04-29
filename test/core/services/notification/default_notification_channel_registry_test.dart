import 'package:bloc_clean_arch/core/services/notification/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DefaultNotificationChannelRegistry', () {
    test('getChannels should return a list of channels', () {
      final registry = DefaultNotificationChannelRegistry();
      final channels = registry.getChannels();
      expect(channels, isA<List>());
    });
  });
}
