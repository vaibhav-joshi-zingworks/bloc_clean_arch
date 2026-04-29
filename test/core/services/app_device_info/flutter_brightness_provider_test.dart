import 'dart:ui';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/flutter_brightness_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('FlutterBrightnessProvider should return a brightness value', () {
    final provider = FlutterBrightnessProvider();
    // In test environment, this should return a default brightness (light)
    expect(provider.getBrightness(), isA<Brightness>());
  });
}
