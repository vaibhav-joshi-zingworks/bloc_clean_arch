/// Interface for implementing different methods to check for actual internet access.
abstract class InternetCheckStrategy {
  /// Returns true if the device can successfully reach the public internet.
  Future<bool> hasInternetAccess();
}
