import 'dart:async';

import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

class TestInternetCheckStrategy implements InternetCheckStrategy {
  TestInternetCheckStrategy(this._result);
  final bool _result;

  @override
  Future<bool> hasInternetAccess() async => _result;
}

class TestNetworkMonitorRepository implements NetworkMonitorRepository {
  TestNetworkMonitorRepository(this._status);

  final NetworkStatus _status;
  final _controller = StreamController<NetworkStatus>.broadcast();

  @override
  Stream<NetworkStatus> observeNetworkStatus() => _controller.stream;

  @override
  Future<NetworkStatus> getCurrentStatus() async => _status;
}

void main() {
  group('NetworkStatus', () {
    test('should include connected and disconnected', () {
      expect(NetworkStatus.values, containsAll(<NetworkStatus>[NetworkStatus.connected, NetworkStatus.disconnected]));
    });
  });

  group('InternetCheckStrategyFactory', () {
    test('createDefault should return DnsLookupInternetStrategy', () {
      final strategy = InternetCheckStrategyFactory.createDefault();
      expect(strategy, isA<DnsLookupInternetStrategy>());
    });
  });

  group('ConnectivityPlusAdapter', () {
    test('onConnectivityChanged should forward stream', () async {
      final mockConnectivity = MockConnectivity();

      final stream = Stream<List<ConnectivityResult>>.fromIterable([
        const [ConnectivityResult.wifi],
      ]);

      when(() => mockConnectivity.onConnectivityChanged).thenAnswer((_) => stream);

      final adapter = ConnectivityPlusAdapter(mockConnectivity);

      final first = await adapter.onConnectivityChanged.first;
      expect(first, const [ConnectivityResult.wifi]);
      verify(() => mockConnectivity.onConnectivityChanged).called(1);
    });

    test('checkConnectivity should forward checkConnectivity()', () async {
      final mockConnectivity = MockConnectivity();

      when(() => mockConnectivity.checkConnectivity()).thenAnswer((_) async => const [
            ConnectivityResult.mobile,
          ]);

      final adapter = ConnectivityPlusAdapter(mockConnectivity);

      final result = await adapter.checkConnectivity();
      expect(result, const [ConnectivityResult.mobile]);
      verify(() => mockConnectivity.checkConnectivity()).called(1);
    });
  });

  group('InternetCheckStrategy', () {
    test('should be implementable and return Future<bool>', () async {
      final strategy = TestInternetCheckStrategy(true);
      expect(await strategy.hasInternetAccess(), isTrue);
    });
  });

  group('DnsLookupInternetStrategy', () {
    test('hasInternetAccess should match the expected signature', () {
      final strategy = DnsLookupInternetStrategy();
      expect(strategy.hasInternetAccess, isA<Future<bool> Function()>());
    });
  });

  group('NetworkMonitorRepository', () {
    test('should be implementable and expose current status', () async {
      final repo = TestNetworkMonitorRepository(NetworkStatus.connected);

      expect(await repo.getCurrentStatus(), NetworkStatus.connected);
    });
  });
}

