import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Adapter interface for abstracting platform-specific device information retrieval.
/// 
/// This allows the [AppDeviceInfoService] to remain platform-agnostic while 
/// specialized implementations handle the native details.
abstract class DeviceInfoAdapter {
  /// Returns a unique identifier for the device.
  Future<String> getDeviceId();
  
  /// Returns the current network connection type (wifi, mobile, etc.).
  Future<String> getNetworkType();
  
  /// Returns the local IP address of the device.
  Future<String> getLocalIpAddress();
  
  /// Constructs a standard User-Agent string using package and hardware info.
  String getUserAgent(PackageInfo packageInfo, AndroidDeviceInfo? android, IosDeviceInfo? ios);
}
