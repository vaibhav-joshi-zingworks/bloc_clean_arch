
import 'xcore.dart';

class SafeDeviceService {
  static bool? _isJailBroken;
  static bool? _isRealDevice;
  static bool? _isMockLocation;
  static bool? _isDevModeEnabled;

  /// Run all cross-platform security checks in parallel
  static Future<bool> initialize() async {
    final results = await Future.wait<bool>([
      SafeDevice.isJailBroken, // root/jailbreak detection
      SafeDevice.isRealDevice, // real device vs emulator
      SafeDevice.isMockLocation, // mock location (Android; harmless on iOS)
      SafeDevice.isDevelopmentModeEnable, // dev mode enabled
    ]);

    _isJailBroken = results[0];
    _isRealDevice = results[1];
    _isMockLocation = results[2];
    _isDevModeEnabled = results[3];

    return (_isJailBroken ?? false) || !(_isRealDevice ?? true) || (_isMockLocation ?? false) || (_isDevModeEnabled ?? false);
  }

  /// Convenience getters
  static bool get isJailBroken => _isJailBroken ?? false;
  static bool get isEmulator => !(_isRealDevice ?? true);
  static bool get mockLocation => _isMockLocation ?? false;
  static bool get devMode => _isDevModeEnabled ?? false;

  /// 🔍 Map utility: return detailed status for logging/debugging
  static Map<String, bool> getSecurityStatus() {
    return {
      'Jail-Broken / Rooted': isJailBroken,
      'Developer Mode Enabled': devMode,
      'Emulator': isEmulator,
      'Mock Location Enabled': mockLocation,
    };
  }
}
