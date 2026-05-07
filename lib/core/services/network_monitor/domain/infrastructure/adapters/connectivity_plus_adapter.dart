import '../../../xcore.dart';

/// Adapter for the [Connectivity] plugin.
/// 
/// Wraps the plugin's functionality to allow for easier mocking in tests and 
/// to keep the domain layer clean of direct plugin dependencies.
class ConnectivityPlusAdapter {
  final Connectivity _connectivity;

  ConnectivityPlusAdapter(this._connectivity);

  /// Stream of connectivity results (Wi-Fi, Mobile, None, etc.).
  Stream<List<ConnectivityResult>> get onConnectivityChanged => _connectivity.onConnectivityChanged;

  /// Performs a one-time check of the current connectivity state.
  Future<List<ConnectivityResult>> checkConnectivity() {
    return _connectivity.checkConnectivity();
  }
}
