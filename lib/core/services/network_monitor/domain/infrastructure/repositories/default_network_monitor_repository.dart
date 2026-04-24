import 'dart:async';

import '../../../xcore.dart';

class DefaultNetworkMonitorRepository implements NetworkMonitorRepository {
  final ConnectivityPlusAdapter connectivityAdapter;
  final InternetCheckStrategy internetCheckStrategy;

  DefaultNetworkMonitorRepository({required this.connectivityAdapter, required this.internetCheckStrategy});

  final _controller = StreamController<NetworkStatus>.broadcast();

  StreamSubscription? _subscription;

  @override
  Stream<NetworkStatus> observeNetworkStatus() {
    _subscription ??= connectivityAdapter.onConnectivityChanged.listen((results) async {
      if (results.first == ConnectivityResult.none) {
        _controller.add(NetworkStatus.disconnected);
      } else {
        final hasInternet = await internetCheckStrategy.hasInternetAccess();

        _controller.add(hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected);
      }
    });

    return _controller.stream;
  }

  @override
  Future<NetworkStatus> getCurrentStatus() async {
    final connectivity = await connectivityAdapter.checkConnectivity();

    if (connectivity.first == ConnectivityResult.none) {
      final hasInternet = await internetCheckStrategy.hasInternetAccess();
      return hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected;
    } else {
      return NetworkStatus.connected;
    }
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
