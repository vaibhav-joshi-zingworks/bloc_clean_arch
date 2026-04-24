class DeviceSecurityStatus {
  final bool isRooted;
  final bool isEmulator;
  final bool isMockLocation;
  final bool isDeveloperMode;

  const DeviceSecurityStatus({
    required this.isRooted,
    required this.isEmulator,
    required this.isMockLocation,
    required this.isDeveloperMode,
  });

  bool get isUnsafe => isRooted || isEmulator || isMockLocation || isDeveloperMode;

  Map<String, bool> toMap() {
    return {'developer_mode': isDeveloperMode, 'rooted_or_jailbroken': isRooted, 'emulator': isEmulator, 'mock_location': isMockLocation};
  }
}
