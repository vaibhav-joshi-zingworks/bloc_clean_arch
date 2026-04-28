
import 'package:bloc_clean_arch/app/xcore.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalMessageCubit extends Cubit<AppMessage?> {
  GlobalMessageCubit() : super(null);

  void showMessage(String message, MessageType type) {
    emit(AppMessage(message: message, type: type));
  }

  void clear() => emit(null);
}