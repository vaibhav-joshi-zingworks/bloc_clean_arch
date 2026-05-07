import 'dart:ui';

/// Interface for providing the current brightness (Light/Dark) of the device.
abstract class BrightnessProvider {
  /// Returns the current [Brightness] from the system or window.
  Brightness getBrightness();
}
