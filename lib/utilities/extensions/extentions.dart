import '../../core.dart';

/// Extension on [String] to provide text formatting utilities.
extension CapitalizeFirst on String {
  /// Returns the string with the first letter capitalized.
  String get capitalizeFirst {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
}

/// Extension on [DateTime] to provide date formatting utilities.
extension DateTimeExtensions on DateTime {
  /// Returns a string representation of the date in YYYY-MM-DD format.
  String get dateOnly {
    return "${year.toString().padLeft(4, '0')}-"
        "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }
}

/// Extension on [Color] to simplify opacity management.
extension ColorOpacity on Color {
  /// Returns a new color with the specified [value] of transparency (0.0 to 1.0).
  Color withTransparency(double value) => withAlpha((value * 255).round());
}

/// Extension on [BuildContext] to simplify access to design system themes.
extension TextThemeX on BuildContext {
  /// Quick access to the [TextTheme] from the current [Theme].
  TextTheme get text => Theme.of(this).textTheme;
}
