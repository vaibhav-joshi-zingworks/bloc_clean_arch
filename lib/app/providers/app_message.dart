import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

class AppMessage {
  final String message;
  final MessageType type;

  AppMessage({
    required this.message,
    required this.type,
  });
}

class GlobalMessageCubit extends Cubit<AppMessage?> {
  GlobalMessageCubit() : super(null);

  void showMessage(String message, MessageType type) {
    emit(AppMessage(message: message, type: type));
  }

  void clear() => emit(null);
}