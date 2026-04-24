import '/core.dart';

class ApiResponseLogInterceptor {

  ApiResponseLogInterceptor();

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
        requestPen: _pen((p) => p.cyan()),
        responsePen: _pen((p) => p.green()),
        errorPen: _pen((p) => p.red()),
      ),
    );
  }

  AnsiPen? _pen(void Function(AnsiPen) style) {
    if (kIsWeb || Platform.isIOS) return null;
    final pen = AnsiPen();
    style(pen);
    return pen;
  }
}