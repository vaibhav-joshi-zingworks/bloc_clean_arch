import 'dart:async';

import '../../../xcore.dart';

/// Default implementation of [NetworkMonitorRepository].
/// 
/// It combines raw connectivity events (Wi-Fi/Mobile) with an [InternetCheckStrategy] 
/// (e.g., DNS lookup) to ensure the device actually has internet access.
class DefaultNetworkMonitorRepository implements NetworkMonitorRepository {
  final ConnectivityPlusAdapter connectivityAdapter;
  final InternetCheckStrategy internetCheckStrategy;

  DefaultNetworkMonitorRepository({
    required this.connectivityAdapter, 
    required this.internetCheckStrategy
  });

  /// Broadcast stream controller to notify multiple listeners about network changes.
  final _controller = StreamController<NetworkStatus>.broadcast();

  /// Subscription to the underlying connectivity changes.
  StreamSubscription? _subscription;

  @override
  Stream<NetworkStatus> observeNetworkStatus() {
    _subscription ??= connectivityAdapter.onConnectivityChanged.listen((results) async {
      if (results.first == ConnectivityResult.none) {
        _controller.add(NetworkStatus.disconnected);
      } else {
        // Even if connected to a network, verify if there is real internet access
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
      return NetworkStatus.disconnected;
    } else {
      // Perform a real internet check to be certain
      final hasInternet = await internetCheckStrategy.hasInternetAccess();
      return hasInternet ? NetworkStatus.connected : NetworkStatus.disconnected;
    }
  }

  /// Closes the stream and cancels subscriptions.
  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
