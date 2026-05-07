
import 'package:bloc_clean_arch/app/xcore.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit used to trigger global UI notifications from anywhere in the app.
/// 
/// Listened to by the [GlobalMessageListener] to show SnackBars or Dialogs.
class GlobalMessageCubit extends Cubit<AppMessage?> {
  GlobalMessageCubit() : super(null);

  /// Emits a new message event to be displayed to the user.
  void showMessage(String message, MessageType type) {
    emit(AppMessage(message: message, type: type));
  }

  /// Clears the current message state.
  void clear() => emit(null);
}
