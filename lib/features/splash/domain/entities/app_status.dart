/// Represents the initial state of the application on startup.
/// 
/// Used by the Splash screen to decide which initial page to navigate to.
enum AppStatus {
  /// User is already logged in.
  authenticated,
  
  /// User is not logged in.
  unauthenticated,
  
  /// The app is being opened for the first time.
  firstLaunch,
}
