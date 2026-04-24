class AppDeviceInfoModel {
  final String networkType;
  final String ip;
  final String? userAgent;
  final String? brand;
  final String? model;
  final String? deviceId;
  final String? osId;
  final String? deviceName;
  final String? name;
  final String? appVersion;
  final String? appId;
  final String? buildNumber;
  final String? platform;
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
