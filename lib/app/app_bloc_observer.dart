import 'package:flutter_bloc/flutter_bloc.dart';
import '../core.dart';

/// Global observer for all Blocs and Cubits in the application.
/// 
/// It monitors the lifecycle (creation, changes, errors, closing) of every Bloc
/// and logs them to the console for easier debugging and performance monitoring.
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logDebug('🟢 Bloc created → ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logDebug(
      '🔄 State changed → ${bloc.runtimeType}\n'
          'Current: ${_shorten(change.currentState)}\n'
          'Next: ${_shorten(change.nextState)}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logError(
      '⚠️ Bloc error → ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    logDebug('🔴 Bloc closed → ${bloc.runtimeType}');
    super.onClose(bloc);
  }

  /// Helper to trim long state output in logs to keep the console clean.
  String _shorten(Object? value) {
    if (value == null) return 'null';

    final str = value.toString();
    return str.length > 300 ? '${str.substring(0, 300)}...' : str;
  }
}
