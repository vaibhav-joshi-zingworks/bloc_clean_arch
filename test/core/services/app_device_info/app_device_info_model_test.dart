import 'package:bloc_clean_arch/core/services/app_device_info/domain/model/app_device_info_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDeviceInfoModel', () {
    final tModel = AppDeviceInfoModel(
      networkType: 'wifi',
      ip: '192.168.1.1',
      deviceId: '123',
    );

    test('should parse from json correctly', () {
      final json = {
        'networkType': 'wifi',
        'ip': '192.168.1.1',
        'deviceId': '123',
      };
      final result = AppDeviceInfoModel.fromJson(json);
      expect(result.networkType, tModel.networkType);
      expect(result.ip, tModel.ip);
    });

    test('should convert to json correctly', () {
      final result = tModel.toJson();
      expect(result['networkType'], 'wifi');
      expect(result['ip'], '192.168.1.1');
    });
  });
}
