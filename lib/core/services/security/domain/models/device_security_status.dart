/// Model representing the aggregated security audit results for the device.
class DeviceSecurityStatus {
  /// True if the device is rooted (Android) or jailbroken (iOS).
  final bool isRooted;
  
  /// True if the application is running on an emulator or simulator.
  final bool isEmulator;
  
  /// True if fake GPS location services are active.
  final bool isMockLocation;
  
  /// True if the device has Developer Options / USB Debugging enabled.
  final bool isDeveloperMode;

  const DeviceSecurityStatus({
    required this.isRooted,
    required this.isEmulator,
    required this.isMockLocation,
    required this.isDeveloperMode,
  });

  /// Returns true if ANY of the security checks failed.
  bool get isUnsafe => isRooted || isEmulator || isMockLocation || isDeveloperMode;

  /// Converts the status into a map for logging or API reporting.
  Map<String, bool> toMap() {
    return {
      'developer_mode': isDeveloperMode, 
      'rooted_or_jailbroken': isRooted, 
      'emulator': isEmulator, 
      'mock_location': isMockLocation
    };
  }
}
