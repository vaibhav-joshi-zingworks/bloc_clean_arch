extension RoutePathExtension on String {
  /// Ensure the path starts with a `/`
  String get path => startsWith('/') ? this : '/$this';
}
