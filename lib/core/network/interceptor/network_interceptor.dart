
import '../../../core.dart';

/// Interceptor that verifies network connectivity before sending any request.
/// 
/// It acts as a gatekeeper, preventing requests from being made when the device
/// is offline, thereby saving resources and providing immediate feedback.
class NetworkInterceptor extends Interceptor {
  final NetworkMonitorService networkMonitorService;

  NetworkInterceptor(this.networkMonitorService);

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Check current connection status via the monitor service
    final isConnected = await networkMonitorService.isConnected();

    // If offline, reject the request immediately with a connection error
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
    }

    // Continue with the request if online
    handler.next(options);
  }
}
