/// Defines the different types of messages that can be displayed to the user.
/// 
/// Used to determine the visual styling (colors, icons) of feedback components 
/// like SnackBars and Dialogs.
enum MessageType { 
  /// Indicates a successful operation.
  success, 
  
  /// Indicates a general informative message.
  general, 
  
  /// Indicates an error or failed operation.
  error, 
  
  /// Indicates a helpful piece of information.
  info, 
  
  /// Indicates a potential issue or caution.
  warning 
}
