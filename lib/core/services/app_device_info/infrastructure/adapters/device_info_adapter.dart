import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Adapter interface for device info
abstract class DeviceInfoAdapter {
  Future<String> getDeviceId();
  Future<String> getNetworkType();
  Future<String> getLocalIpAddress();
  String getUserAgent(PackageInfo packageInfo, AndroidDeviceInfo? android, IosDeviceInfo? ios);
}
