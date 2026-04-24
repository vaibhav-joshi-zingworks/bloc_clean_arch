import '../../../xcore.dart';

class ConnectivityPlusAdapter {
  final Connectivity _connectivity;

  ConnectivityPlusAdapter(this._connectivity);

  Stream<List<ConnectivityResult>> get onConnectivityChanged => _connectivity.onConnectivityChanged;

  Future<List<ConnectivityResult>> checkConnectivity() {
    return _connectivity.checkConnectivity();
  }
}
