
import '../../../core.dart';

class LoggerService {
  LoggerService._();

  static final Talker talker = Talker(settings: TalkerSettings(enabled: true, useConsoleLogs: true));
}

void logInfo(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.info(message);
}

void logWarning(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.warning(message);
}

void logDebug(String message) {
  if (!kDebugMode) return;
  LoggerService.talker.debug(message);
}

void logError(String message, {Object? error, StackTrace? stackTrace}) {
  if (!kDebugMode) return;
  LoggerService.talker.error(message, error, stackTrace);
}
