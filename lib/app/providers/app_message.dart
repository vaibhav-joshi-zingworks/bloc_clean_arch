import 'package:bloc_clean_arch/core.dart';

/// Data class representing a global UI message (SnackBar, Toast, or Dialog).
class AppMessage {

  AppMessage({
    required this.message,
    required this.type,
  });

  /// The text content of the message.
  final String message;

  /// The category of the message (Success, Error, Info, Warning).
  final MessageType type;
}
