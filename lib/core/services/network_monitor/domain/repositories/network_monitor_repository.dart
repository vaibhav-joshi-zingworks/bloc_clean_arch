import '../../xcore.dart';

abstract class NetworkMonitorRepository {
  Stream<NetworkStatus> observeNetworkStatus();
  Future<NetworkStatus> getCurrentStatus();
}
