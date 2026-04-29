import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNetworkMonitorRepository extends Mock implements NetworkMonitorRepository {}

void main() {
  late NetworkMonitorService service;
  late MockNetworkMonitorRepository mockRepository;

  setUp(() {
    mockRepository = MockNetworkMonitorRepository();
    service = NetworkMonitorService(mockRepository);
  });

  group('NetworkMonitorService', () {
    test('isConnected should return true when status is connected', () async {
      when(() => mockRepository.getCurrentStatus()).thenAnswer((_) async => NetworkStatus.connected);
      final result = await service.isConnected();
      expect(result, true);
    });

    test('isConnected should return false when status is disconnected', () async {
      when(() => mockRepository.getCurrentStatus()).thenAnswer((_) async => NetworkStatus.disconnected);
      final result = await service.isConnected();
      expect(result, false);
    });

    test('observe should return stream from repository', () {
      final stream = Stream.fromIterable([NetworkStatus.connected]);
      when(() => mockRepository.observeNetworkStatus()).thenAnswer((_) => stream);
      
      expect(service.observe(), emits(NetworkStatus.connected));
    });
  });
}
