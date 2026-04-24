import '../../core.dart';

class Parser {
  static Future<Either<AppException, BaseResponse<T>>> parseBaseResponse<T>(
      Response response, ResponseMapper<T> mapper) async {
    try {
      final json = Map<String, dynamic>.from(response.data);

      final bool status = json['status'] ?? false;
      final String message = json['message'] ?? '';

      if (!status) {
        return Left(ValidationError(message: message));
      }

      final rawData =
      (json['data'] == null || json['data'].isEmpty) ? null : json['data'];
      final rawPagination = json['pagination'];

      final parsedData = rawData == null ? null : mapper.fromJson(rawData);
      final pagination = rawPagination == null
          ? null
          : Pagination.fromJson(Map<String, dynamic>.from(rawPagination));

      return Right(BaseResponse<T>(
          status: status,
          message: message,
          data: parsedData,
          pagination: pagination));
    } catch (e) {
      logError("Parser error: $e");
      return Left(ParsingError());
    }
  }
}
