
import '../../../core.dart';


class NetworkInterceptor extends Interceptor {
  final NetworkMonitorService networkMonitorService;

  NetworkInterceptor(this.networkMonitorService);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final isConnected = await networkMonitorService.isConnected();

    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
    }

    handler.next(options);
  }
}