import 'package:bloc_clean_arch/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Data class representing a global UI message.
class AppMessage {
  AppMessage({
    required this.message,
    required this.type,
  });

  /// The text content of the message.
  final String message;

  /// The category of the message.
  final MessageType type;
}

abstract class GlobalMessageEvent extends Equatable {
  const GlobalMessageEvent();

  @override
  List<Object?> get props => [];
}

class GlobalMessageShown extends GlobalMessageEvent {
  const GlobalMessageShown({
    required this.message,
    required this.type,
  });

  final String message;
  final MessageType type;

  @override
  List<Object?> get props => [message, type];
}

class GlobalMessageCleared extends GlobalMessageEvent {
  const GlobalMessageCleared();
}

/// Bloc used to trigger global UI notifications from anywhere in the app.
class GlobalMessageBloc extends Bloc<GlobalMessageEvent, AppMessage?> {
  GlobalMessageBloc() : super(null) {
    on<GlobalMessageShown>(
      (event, emit) =>
          emit(AppMessage(message: event.message, type: event.type)),
    );
    on<GlobalMessageCleared>((event, emit) => emit(null));
  }
}

/// A wrapper widget that listens for global messages and displays SnackBars.
class GlobalMessageListener extends StatelessWidget {
  const GlobalMessageListener({super.key, required this.child});

  /// The underlying widget tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalMessageBloc, AppMessage?>(
      bloc: sl<GlobalMessageBloc>(),
      listener: (context, message) {
        if (message == null) return;

        Utils.snackBar(message.message, result: message.type);
        sl<GlobalMessageBloc>().add(const GlobalMessageCleared());
      },
      child: child,
    );
  }
}
