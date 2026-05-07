import '../../xcore.dart';

/// Repository for accessing application and device-specific information.
abstract class DeviceInfoRepository {
  /// Provides the cached [AppDeviceInfoModel] containing device metadata.
  AppDeviceInfoModel? get deviceInfo;
  
  /// Fetches and caches device information from the platform.
  Future<void> initialise();
}
