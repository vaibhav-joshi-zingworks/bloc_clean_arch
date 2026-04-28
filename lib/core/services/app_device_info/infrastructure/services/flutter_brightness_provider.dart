import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';

class FlutterBrightnessProvider implements BrightnessProvider {
  @override
  Brightness getBrightness() {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}