
import 'xcore.dart';

class NetworkMonitorService {
  final NetworkMonitorRepository repository;

  NetworkMonitorService(this.repository);

  Stream<NetworkStatus> observe() {
    return repository.observeNetworkStatus();
  }

  Future<bool> isConnected() async {
    final status = await repository.getCurrentStatus();
    return status == NetworkStatus.connected;
  }
}
