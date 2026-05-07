/// Data model representing comprehensive information about the device and application.
/// 
/// This model is used to pass device metadata to APIs for security, 
/// analytics, and debugging purposes.
class AppDeviceInfoModel {
  /// Type of internet connection (Wi-Fi, Mobile, etc.).
  final String networkType;
  
  /// The current local IP address of the device.
  final String ip;
  
  /// The HTTP User-Agent string.
  final String? userAgent;
  
  /// The hardware brand (e.g., Google, Apple).
  final String? brand;
  
  /// The specific hardware model (e.g., Pixel 6, iPhone 13).
  final String? model;
  
  /// A unique identifier for the device.
  final String? deviceId;
  
  /// The operating system's unique identifier.
  final String? osId;
  
  /// The user-defined name of the device.
  final String? deviceName;
  
  /// The manufacturer's name.
  final String? name;
  
  /// The current semantic version of the app.
  final String? appVersion;
  
  /// The package name or bundle ID of the app.
  final String? appId;
  
  /// The internal build number of the app.
  final String? buildNumber;
  
  /// The platform (android/ios).
  final String? platform;
  
  /// The version of the operating system.
  final String? osVersion;

  AppDeviceInfoModel({
    required this.networkType,
    required this.ip,
    this.userAgent,
    this.brand,
    this.model,
    this.deviceId,
    this.osId,
    this.deviceName,
    this.name,
    this.appVersion,
    this.appId,
    this.buildNumber,
    this.platform,
    this.osVersion,
  });

  factory AppDeviceInfoModel.fromJson(Map<String, dynamic> json) {
    return AppDeviceInfoModel(
      networkType: json['networkType'],
      ip: json['ip'],
      userAgent: json['userAgent'],
      brand: json['brand'],
      model: json['model'],
      deviceId: json['deviceId'],
      osId: json['osId'],
      deviceName: json['deviceName'],
      name: json['name'],
      appVersion: json['appVersion'],
      appId: json['appId'],
      buildNumber: json['buildNumber'],
      platform: json['platform'],
      osVersion: json['osVersion'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'networkType': networkType,
      'ip': ip,
      'userAgent': userAgent,
      'brand': brand,
      'model': model,
      'deviceId': deviceId,
      'osId': osId,
      'deviceName': deviceName,
      'name': name,
      'appVersion': appVersion,
      'appId': appId,
      'buildNumber': buildNumber,
      'platform': platform,
      'osVersion': osVersion,
    };
  }
}
