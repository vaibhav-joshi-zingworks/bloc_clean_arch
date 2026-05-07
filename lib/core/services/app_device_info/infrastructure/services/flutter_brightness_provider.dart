import 'package:bloc_clean_arch/core.dart';
import 'package:bloc_clean_arch/core/services/app_device_info/infrastructure/services/brightness_provider.dart';

/// Implementation of [BrightnessProvider] using Flutter's [PlatformDispatcher].
class FlutterBrightnessProvider implements BrightnessProvider {
  @override
  Brightness getBrightness() {
    // Access the system's brightness setting (Light/Dark mode)
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}
