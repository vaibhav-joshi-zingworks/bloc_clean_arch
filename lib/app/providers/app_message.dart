import 'package:bloc_clean_arch/core.dart';

class AppMessage {

  AppMessage({
    required this.message,
    required this.type,
  });
  final String message;
  final MessageType type;
}
