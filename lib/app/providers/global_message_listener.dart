import 'package:bloc_clean_arch/app/providers/global_message_cubit.dart';
import 'package:bloc_clean_arch/app/xcore.dart';
import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A wrapper widget that listens for global messages and displays them as SnackBars.
/// 
/// This should be placed high in the widget tree (usually in [App.builder]).
class GlobalMessageListener extends StatelessWidget {

  const GlobalMessageListener({super.key, required this.child});
  
  /// The underlying widget tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalMessageCubit, AppMessage?>(
      bloc: sl<GlobalMessageCubit>(),
      listener: (context, message) {
        if (message == null) return;

        // Map the MessageType to the appropriate UI snackbar/toast
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

        // Auto-clear the state after showing to avoid duplicate triggers
        sl<GlobalMessageCubit>().clear();
      },
      child: child,
    );
  }
}
