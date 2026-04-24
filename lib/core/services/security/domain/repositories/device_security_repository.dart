
import '../../xcore.dart';

abstract class DeviceSecurityRepository {
  Future<DeviceSecurityStatus> getSecurityStatus();
}
