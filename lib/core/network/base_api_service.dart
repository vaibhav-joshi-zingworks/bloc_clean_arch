import '../../core.dart';

abstract class BaseApiService {
  Future<Either<AppException, BaseResponse<T>>> get<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  Future<Either<AppException, BaseResponse<T>>> post<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  Future<Either<AppException, BaseResponse<T>>> put<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  Future<Either<AppException, BaseResponse<T>>> patch<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });

  Future<Either<AppException, BaseResponse<T>>> delete<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      });
}