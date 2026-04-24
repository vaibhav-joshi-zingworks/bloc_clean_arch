import '../../xcore.dart';

class SafeDeviceService implements DeviceSecurityRepository {
  final SafeDeviceAdapter _adapter;

  SafeDeviceService(this._adapter);

  DeviceSecurityStatus? _cachedStatus;

  @override
  Future<DeviceSecurityStatus> getSecurityStatus() async {
    if (_cachedStatus != null) return _cachedStatus!;

    final results = await Future.wait<bool>([
      _adapter.isJailBroken(),
      _adapter.isRealDevice(),
      _adapter.isMockLocation(),
      _adapter.isDevModeEnabled(),
    ]);

    final status = DeviceSecurityStatus(
      isRooted: results[0],
      isEmulator: !results[1],
      isMockLocation: results[2],
      isDeveloperMode: results[3],
    );

    _cachedStatus = status;

    return status;
  }
}
