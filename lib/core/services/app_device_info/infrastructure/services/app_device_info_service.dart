import 'dart:async';

import 'package:package_info_plus/package_info_plus.dart';

import '/core.dart';

/// Service implementation of [DeviceInfoRepository] that gathers system information.
/// 
/// It collects package info, device hardware details, network status, and 
/// unique identifiers to build a comprehensive [AppDeviceInfoModel].
class AppDeviceInfoService implements DeviceInfoRepository {
  AppDeviceInfoService._internal();
  static final AppDeviceInfoService _instance = AppDeviceInfoService._internal();
  factory AppDeviceInfoService() => _instance;

  @override
  AppDeviceInfoModel? deviceInfo;

  DeviceInfoPlugin? _deviceInfoPlugin;
  PackageInfo? _packageInfo;
  AndroidDeviceInfo? _android;
  IosDeviceInfo? _ios;
  bool _initialized = false;

  late final DeviceInfoAdapter _adapter;

  @override
  Future<void> initialise({DeviceInfoAdapter? adapter}) async {
    if (_initialized) return;

    _deviceInfoPlugin = DeviceInfoPlugin();
    _adapter = adapter ?? DefaultDeviceInfoAdapter(_deviceInfoPlugin!);

    try {
      // Gather all required platform info in parallel
      final results = await Future.wait([
        PackageInfo.fromPlatform(),
        _adapter.getDeviceId(),
        _adapter.getLocalIpAddress(),
        _adapter.getNetworkType(),
        if (Platform.isAndroid) _deviceInfoPlugin!.androidInfo,
        if (Platform.isIOS) _deviceInfoPlugin!.iosInfo,
      ]);

      _packageInfo = results[0] as PackageInfo;
      final deviceId = results[1] as String;
      final ip = results[2] as String;
      final networkType = results[3] as String;
      if (Platform.isAndroid) _android = results[4] as AndroidDeviceInfo;
      if (Platform.isIOS) _ios = results[4] as IosDeviceInfo;

      // Construct a standard User-Agent string for the app
      final userAgent = _adapter.getUserAgent(_packageInfo!, _android, _ios);

      // Build and cache the domain model
      deviceInfo = _buildDeviceInfoModel(deviceId: deviceId, ip: ip, networkType: networkType, userAgent: userAgent);

      _initialized = true;
      debugPrint("DeviceInfo: ${deviceInfo?.toJson()}");
    } catch (e) {
      debugPrint("Failed to initialize device info: $e");
      deviceInfo = null;
    }
  }

  /// Maps native device and package data into the cross-platform [AppDeviceInfoModel].
  AppDeviceInfoModel? _buildDeviceInfoModel({
    required String deviceId,
    required String ip,
    required String networkType,
    required String userAgent,
  }) {
    final platform = _getPlatform();
    if (Platform.isAndroid) {
      return AppDeviceInfoModel(
        ip: ip,
        networkType: networkType,
        osVersion: _android?.version.release,
        deviceId: deviceId,
        osId: _android?.id,
        deviceName: _android?.model,
        name: _android?.manufacturer,
        brand: _android?.brand,
        model: _android?.model,
        userAgent: userAgent,
        appId: _packageInfo?.packageName,
        appVersion: _packageInfo?.version,
        buildNumber: _packageInfo?.buildNumber,
        platform: platform,
      );
    } else if (Platform.isIOS) {
      return AppDeviceInfoModel(
        ip: ip,
        networkType: networkType,
        deviceId: deviceId,
        osId: _ios?.identifierForVendor,
        deviceName: _ios?.model,
        name: _ios?.name,
        brand: _ios?.localizedModel,
        model: _ios?.modelName,
        userAgent: userAgent,
        osVersion: _ios?.systemVersion,
        appId: _packageInfo?.packageName,
        appVersion: _packageInfo?.version,
        buildNumber: _packageInfo?.buildNumber,
        platform: platform,
      );
    } else {
      logError("Unsupported platform");
      return null;
    }
  }

  /// Helper to get a standardized platform string.
  String _getPlatform() {
    switch (Platform.operatingSystem) {
      case 'android':
        return 'android';
      case 'ios':
        return 'ios';
      default:
        return 'unknown';
    }
  }
}
