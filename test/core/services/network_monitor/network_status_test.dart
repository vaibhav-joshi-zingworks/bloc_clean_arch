import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetworkStatus', () {
    test('should have expected values', () {
      expect(NetworkStatus.values, contains(NetworkStatus.connected));
      expect(NetworkStatus.values, contains(NetworkStatus.disconnected));
    });
  });
}
