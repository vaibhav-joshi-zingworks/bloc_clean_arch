import '../../xcore.dart';

class SafeDeviceAdapter {
  Future<bool> isJailBroken() => SafeDevice.isJailBroken;

  Future<bool> isRealDevice() => SafeDevice.isRealDevice;

  Future<bool> isMockLocation() => SafeDevice.isMockLocation;

  Future<bool> isDevModeEnabled() => SafeDevice.isDevelopmentModeEnable;
}
