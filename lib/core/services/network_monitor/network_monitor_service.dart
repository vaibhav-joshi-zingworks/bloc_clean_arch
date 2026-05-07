
import 'xcore.dart';

/// Service for tracking the device's internet connectivity status.
/// 
/// It provides both a one-time check ([isConnected]) and a continuous 
/// stream ([observe]) to react to network changes in real-time.
class NetworkMonitorService {
  final NetworkMonitorRepository repository;

  NetworkMonitorService(this.repository);

  /// Returns a [Stream] that emits the current [NetworkStatus] whenever it changes.
  Stream<NetworkStatus> observe() {
    return repository.observeNetworkStatus();
  }

  /// Performs a one-time check to see if the device is currently online.
  Future<bool> isConnected() async {
    final status = await repository.getCurrentStatus();
    return status == NetworkStatus.connected;
  }
}
