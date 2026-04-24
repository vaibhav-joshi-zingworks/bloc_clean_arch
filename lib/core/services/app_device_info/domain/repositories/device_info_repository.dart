import '../../xcore.dart';

abstract class DeviceInfoRepository {
  AppDeviceInfoModel? get deviceInfo;
  Future<void> initialise();
}
