import '../../xcore.dart';

/// Repository interface for monitoring the device's network connectivity.
abstract class NetworkMonitorRepository {
  /// Provides a stream of [NetworkStatus] updates.
  Stream<NetworkStatus> observeNetworkStatus();
  
  /// Fetches the current [NetworkStatus] of the device.
  Future<NetworkStatus> getCurrentStatus();
}
