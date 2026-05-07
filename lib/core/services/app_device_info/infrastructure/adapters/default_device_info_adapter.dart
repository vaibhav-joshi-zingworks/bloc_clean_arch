import 'package:package_info_plus/package_info_plus.dart';
import 'package:unique_device_identifier/unique_device_identifier.dart';

import '../../../../../core.dart';

/// Default implementation of [DeviceInfoAdapter] using standard Flutter community plugins.
class DefaultDeviceInfoAdapter implements DeviceInfoAdapter {
  final DeviceInfoPlugin deviceInfo;

  DefaultDeviceInfoAdapter(this.deviceInfo);

  @override
  Future<String> getDeviceId() async {
    try {
      // Uses unique_device_identifier to get a persistent ID across app installs
      final id = await UniqueDeviceIdentifier.getUniqueIdentifier();
      return id ?? "unknown";
    } catch (e) {
      return "unknown";
    }
  }

  @override
  Future<String> getNetworkType() async {
    // Uses connectivity_plus to check the primary connection type
    final result = await Connectivity().checkConnectivity();
    return result.first.name;
  }

  @override
  Future<String> getLocalIpAddress() async {
    try {
      // Iterates through network interfaces to find the primary IPv4 address
      final interfaces = await NetworkInterface.list();
      for (var interface in interfaces) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) return addr.address;
        }
      }
    } catch (_) {}
    return "unknown";
  }

  @override
  String getUserAgent(PackageInfo packageInfo, AndroidDeviceInfo? android, IosDeviceInfo? ios) {
    // Format: AppName/Version (Platform; OSVersion; Model)
    final info = "Bloc_clean_arch/${packageInfo.version}";
    if (Platform.isAndroid) return "$info (Android ${android?.version.release}; ${android?.model})";
    if (Platform.isIOS) return "$info (iOS ${ios?.systemVersion}; ${ios?.utsname.machine})";
    return "$info (Unknown Platform)";
  }
}
