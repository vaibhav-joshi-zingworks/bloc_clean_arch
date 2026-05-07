import '../../core.dart';

/// Utility class to generate [MaterialColor] swatches from a single color value.
class CustomMaterialColor {
  /// Generates a [MaterialColor] where all shades use the same [customColor].
  /// 
  /// This is useful for maintaining branding across Material components that
  /// expect a color swatch.
  static MaterialColor generate(int customColor) {
    return MaterialColor(customColor, <int, Color>{
      50: Color(customColor),
      100: Color(customColor),
      200: Color(customColor),
      300: Color(customColor),
      400: Color(customColor),
      500: Color(customColor),
      600: Color(customColor),
      700: Color(customColor),
      800: Color(customColor),
      900: Color(customColor),
    });
  }
}