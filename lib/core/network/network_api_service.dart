
import '../../core.dart';

class NetworkApiService implements BaseApiService {
  final Dio _dio;

  NetworkApiService(this._dio);

  Future<Either<AppException, BaseResponse<T>>> _request<T>(
      Future<Response> Function() requestCall,
      ResponseMapper<T> mapper,
      ) async {
    try {
      final response = await requestCall();

      final parsed = await Parser.parseBaseResponse<T>(
        response,
        mapper,
      );

      return parsed;
    } on DioException catch (e) {
      return Left(Failure.handleDioError(e));
    } catch (e) {
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