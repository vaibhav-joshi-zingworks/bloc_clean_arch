import '../../core.dart';

/// Abstract contract for performing HTTP network operations.
/// 
/// This allows for swapping different networking clients (e.g., Dio, Http) 
/// without affecting the rest of the application.
abstract class BaseApiService {
  
  /// Sends a GET request to the specified [endpoint].
  Future<Either<AppException, BaseResponse<T>>> get<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  /// Sends a POST request to the specified [endpoint].
  Future<Either<AppException, BaseResponse<T>>> post<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  /// Sends a PUT request to the specified [endpoint].
  Future<Either<AppException, BaseResponse<T>>> put<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  /// Sends a PATCH request to the specified [endpoint].
  Future<Either<AppException, BaseResponse<T>>> patch<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  /// Sends a DELETE request to the specified [endpoint].
  Future<Either<AppException, BaseResponse<T>>> delete<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });
}
