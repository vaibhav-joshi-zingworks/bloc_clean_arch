import '../../core.dart';

/// Implementation of [BaseApiService] using the [Dio] package.
/// 
/// It centralizes the execution of network requests and handles 
/// high-level mapping from raw responses to [BaseResponse] objects.
class NetworkApiService implements BaseApiService {
  final Dio _dio;

  NetworkApiService(this._dio);

  /// Private helper to execute requests and handle common error states.
  Future<Either<AppException, BaseResponse<T>>> _request<T>(
      Future<Response> Function() requestCall,
      ResponseMapper<T> mapper,
      ) async {
    try {
      final response = await requestCall();

      // Trigger the parser to structure the JSON data
      final parsed = await Parser.parseBaseResponse<T>(
        response,
        mapper,
      );

      return parsed;
    } on DioException catch (e) {
      // Map technical Dio errors to domain AppException
      return Left(Failure.handleDioError(e));
    } catch (e) {
      // Fallback for unexpected parsing or runtime errors
      return Left(ParsingError());
    }
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> get<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) {
    return _request(
          () => _dio.get(
        endpoint,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> post<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) {
    return _request(
          () => _dio.post(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> put<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) {
    return _request(
          () => _dio.put(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> patch<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) {
    return _request(
          () => _dio.patch(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }

  @override
  Future<Either<AppException, BaseResponse<T>>> delete<T>(
      String endpoint,
      ResponseMapper<T> mapper, {
        dynamic body,
        Options? options,
        Map<String, dynamic>? queryParameters,
        CancelToken? cancelToken,
      }) {
    return _request(
          () => _dio.delete(
        endpoint,
        data: body,
        options: options,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      ),
      mapper,
    );
  }
}
