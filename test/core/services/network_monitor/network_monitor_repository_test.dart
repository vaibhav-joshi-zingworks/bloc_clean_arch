import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkMonitorRepository extends Mock implements NetworkMonitorRepository {}

void main() {
  group('NetworkMonitorRepository', () {
    test('can be mocked', () {
      final repository = MockNetworkMonitorRepository();
      expect(repository, isA<NetworkMonitorRepository>());
    });
  });
}
