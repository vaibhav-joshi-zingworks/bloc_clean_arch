/// Abstract interface for Push Notification cloud messaging services (e.g. Firebase Cloud Messaging).
/// 
/// This allows the app to handle device registration tokens and topic subscriptions
/// independently of the specific backend provider.
abstract class MessagingService {
  /// Initializes the messaging engine (requesting permissions, setting up listeners).
  Future<void> initialize();
  
  /// Retrieves the unique device registration token for push notifications.
  Future<String?> getToken();
  
  /// Subscribes the device to a specific broadcast [topic].
  Future<void> subscribeToTopic(String topic);
  
  /// Unsubscribes the device from a specific broadcast [topic].
  Future<void> unsubscribeFromTopic(String topic);
}
