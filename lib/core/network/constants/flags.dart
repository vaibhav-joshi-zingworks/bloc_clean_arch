/// Centralized string identifiers used as keys for local storage and flags.
/// 
/// These constants ensure consistency when saving and retrieving data across
/// the application's different modules.
class Flags {
  /// Flag to track if system permissions have been requested/granted.
  static const String permission = "permission";
  
  /// Flag to track if the user has completed the onboarding flow.
  static const String onboarding = "onboarding";
  
  /// Key used to store the primary JWT Access Token.
  static const String token = "token";
  
  /// Key used to store the OAuth Refresh Token.
  static const String refreshToken = "refreshToken";
  
  /// Key used to store the Firebase Cloud Messaging device token.
  static const String fcmToken = "fcmToken";
  
  /// Key used to store the unique identifier of the logged-in user.
  static const String userId = "userId";
  
  /// Flag to track the registration status of the user profile.
  static const String isRegistered = "isRegistered";
}
