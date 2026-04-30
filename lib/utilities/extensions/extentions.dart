import '../../core.dart';

extension CapitalizeFirst on String {
  String get capitalizeFirst {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
}

extension DateTimeExtensions on DateTime {
  String get dateOnly {
    return "${year.toString().padLeft(4, '0')}-"
        "${month.toString().padLeft(2, '0')}-"
        "${day.toString().padLeft(2, '0')}";
  }
}

extension ColorOpacity on Color {
  Color withTransparency(double value) => withAlpha((value * 255).round());
}

extension TextThemeX on BuildContext {
  TextTheme get text => Theme.of(this).textTheme;
}
