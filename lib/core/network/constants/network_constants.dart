/// Standardized HTTP header keys used for API communication.
/// 
/// These constants provide a single source of truth for header naming,
/// including security tokens, device metadata, and auth tokens.
class HeaderKey {
  /// Default headers to be included in all JSON requests.
  static const header = {'Accept': 'application/json'};
  
  /// Custom header for the mobile app's package/bundle identifier.
  static const String packageName = 'x-package-name';
  
  /// Custom header for the current application semantic version.
  static const String appVersion = 'x-app-version';
  
  /// Custom header identifying the operating system (android/ios).
  static const String platform = 'x-platform';
  
  /// Custom header for the specific OS version of the device.
  static const String osVersion = 'x-os-version';
  
  /// Security header used for Google Play / App Store integrity checks.
  static const String integrityToken = 'x-integrity-token';
  
  /// A static secret key used for low-level application authentication.
  static const String appSecret = 'x-app-secret';
  
  /// The standard HTTP 'Authorization' header key.
  static const String authorization = 'authorization';
  
  /// Custom header for passing the refresh token to the server.
  static const String refreshToken = 'refresh-token';
}

/// General application-level constants related to stores and external links.
class Constants{
  /// Direct link to the app on the Google Play Store.
  static const String playStoreUrl = '';
  
  /// Direct link to the app on the Apple App Store.
  static const String appStoreUrl = '';
}
