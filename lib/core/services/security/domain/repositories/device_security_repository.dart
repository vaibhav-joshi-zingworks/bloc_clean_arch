
import '../../xcore.dart';

/// Repository interface for auditing the security environment of the device.
abstract class DeviceSecurityRepository {
  /// Aggregates various security checks (Root, Emulator, DevMode) into a single status model.
  Future<DeviceSecurityStatus> getSecurityStatus();
}
