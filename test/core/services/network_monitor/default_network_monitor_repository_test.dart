import 'package:bloc_clean_arch/core/services/network_monitor/domain/infrastructure/repositories/default_network_monitor_repository.dart';
import 'package:bloc_clean_arch/core/services/network_monitor/xcore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivityPlusAdapter extends Mock implements ConnectivityPlusAdapter {}
class MockInternetCheckStrategy extends Mock implements InternetCheckStrategy {}

void main() {
  late DefaultNetworkMonitorRepository repository;
  late MockConnectivityPlusAdapter mockConnectivity;
  late MockInternetCheckStrategy mockInternet;

  setUp(() {
    mockConnectivity = MockConnectivityPlusAdapter();
    mockInternet = MockInternetCheckStrategy();
    repository = DefaultNetworkMonitorRepository(
      connectivityAdapter: mockConnectivity,
      internetCheckStrategy: mockInternet,
    );
  });

  group('DefaultNetworkMonitorRepository', () {
    test('getCurrentStatus returns connected when connectivity is not none', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      
      final result = await repository.getCurrentStatus();
      
      expect(result, NetworkStatus.connected);
    });

    test('getCurrentStatus returns disconnected when connectivity is none and no internet access', () async {
      when(() => mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(() => mockInternet.hasInternetAccess()).thenAnswer((_) async => false);
      
      final result = await repository.getCurrentStatus();
      
      expect(result, NetworkStatus.disconnected);
    });

    test('observeNetworkStatus emits disconnected when connectivity changes to none', () async {
      when(() => mockConnectivity.onConnectivityChanged)
          .thenAnswer((_) => Stream.fromIterable([[ConnectivityResult.none]]));
      
      expect(repository.observeNetworkStatus(), emits(NetworkStatus.disconnected));
    });
  });
}
