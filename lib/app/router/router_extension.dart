/// Extension on [String] to handle route path formatting.
extension RoutePathExtension on String {
  /// Ensures the string is formatted as a valid [GoRouter] path.
  /// 
  /// Guaranteed to start with a forward slash (`/`).
  String get path => startsWith('/') ? this : '/$this';
}
