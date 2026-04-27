import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core.dart';
import '../xcore.dart';

class GlobalMessageListener extends StatelessWidget {
  final Widget child;

  const GlobalMessageListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalMessageCubit, AppMessage?>(
      bloc: sl<GlobalMessageCubit>(),
      listener: (context, message) {
        if (message == null) return;

        switch (message.type) {
          case MessageType.success:
            Utils.snackBar(message.message, result: MessageType.success);
            break;

          case MessageType.error:
            Utils.snackBar(message.message, result: MessageType.error);
            break;

          case MessageType.info:
            Utils.snackBar(message.message, result: MessageType.info);
            break;

          case MessageType.warning:
            Utils.snackBar(message.message, result: MessageType.warning);
            break;

          case MessageType.general:
            Utils.snackBar(message.message, result: MessageType.general);
            break;
        }

        sl<GlobalMessageCubit>().clear();
      },
      child: child,
    );
  }
}