
import '../../../core.dart';

/// Central service for application-wide logging.
/// 
/// Powered by the [Talker] package to provide formatted, categorized logs.
class LoggerService {
  LoggerService._();

  /// Global instance of Talker.
  static final Talker talker = Talker(settings: TalkerSettings(enabled: true, useConsoleLogs: true));
}

/// Logs an informational message.
void logInfo(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.info(message);
}

/// Logs a warning message.
void logWarning(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.warning(message);
}

/// Logs a debug message.
void logDebug(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.debug(message);
}

/// Logs an error message along with an optional error object and stack trace.
void logError(String message, {Object? error, StackTrace? stackTrace}) {
  if (!kDebugMode) return;
  LoggerService.talker.error(message, error, stackTrace);
}
