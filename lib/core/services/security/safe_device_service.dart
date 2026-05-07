
import 'xcore.dart';

/// Service for detecting if the device environment is "unsafe" for the application.
/// 
/// It checks for Root/Jailbreak status, Emulator usage, Mock Locations, 
/// and Developer Mode, which is critical for fintech and high-security apps.
class SafeDeviceService {
  static bool? _isJailBroken;
  static bool? _isRealDevice;
  static bool? _isMockLocation;
  static bool? _isDevModeEnabled;

  /// Performs all cross-platform security checks in parallel and returns true 
  /// if ANY security risk is detected.
  static Future<bool> initialize() async {
    final results = await Future.wait<bool>([
      SafeDevice.isJailBroken, // Detects if the device is rooted or jailbroken
      SafeDevice.isRealDevice, // Detects if the app is running on a physical device
      SafeDevice.isMockLocation, // Detects if mock locations are enabled (primarily Android)
      SafeDevice.isDevelopmentModeEnable, // Detects if USB debugging / Dev mode is active
    ]);

    _isJailBroken = results[0];
    _isRealDevice = results[1];
    _isMockLocation = results[2];
    _isDevModeEnabled = results[3];

    // Return true if the environment is considered unsafe
    return (_isJailBroken ?? false) || !(_isRealDevice ?? true) || (_isMockLocation ?? false) || (_isDevModeEnabled ?? false);
  }

  /// Returns true if the device is rooted or jailbroken.
  static bool get isJailBroken => _isJailBroken ?? false;
  
  /// Returns true if the app is running on an emulator or simulator.
  static bool get isEmulator => !(_isRealDevice ?? true);
  
  /// Returns true if the device is using fake/mock GPS locations.
  static bool get mockLocation => _isMockLocation ?? false;
  
  /// Returns true if Developer Options are enabled on the device.
  static bool get devMode => _isDevModeEnabled ?? false;

  /// Returns a detailed map of all security check results for logging or debugging.
  static Map<String, bool> getSecurityStatus() {
    return {
      'Jail-Broken / Rooted': isJailBroken,
      'Developer Mode Enabled': devMode,
      'Emulator': isEmulator,
      'Mock Location Enabled': mockLocation,
    };
  }
}
