import '/core.dart';

/// A factory class that creates a Dio interceptor for advanced logging.
/// 
/// It utilizes the [TalkerDioLogger] to provide beautifully formatted logs 
/// for network requests, responses, and errors directly in the console.
class ApiResponseLogInterceptor {

  ApiResponseLogInterceptor();

  /// Creates and configures the [TalkerDioLogger] interceptor.
  /// 
  /// Logging is automatically toggled based on the [kDebugMode] flag 
  /// to ensure logs are only visible during development.
  Interceptor create() {
    return TalkerDioLogger(
      talker: LoggerService.talker,
      settings: TalkerDioLoggerSettings(
        enabled: kDebugMode,
        printRequestData: kDebugMode,
        printRequestHeaders: false,
        printErrorHeaders: false,
        printErrorData: kDebugMode,
        printResponseData: kDebugMode,
        printResponseTime: kDebugMode,
        printResponseMessage: kDebugMode,
        // Define terminal colors for different log types
        requestPen: _pen((p) => p.cyan()),
        responsePen: _pen((p) => p.green()),
        errorPen: _pen((p) => p.red()),
      ),
    );
  }

  /// Helper to create colored terminal output (AnsiPen).
  /// 
  /// Colors are disabled for Web and iOS platforms as they don't support 
  /// standard ANSI escape codes in their respective console environments.
  AnsiPen? _pen(void Function(AnsiPen) style) {
    if (kIsWeb || Platform.isIOS) return null;
    final pen = AnsiPen();
    style(pen);
    return pen;
  }
}
