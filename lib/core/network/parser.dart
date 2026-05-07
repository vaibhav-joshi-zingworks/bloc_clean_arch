import '../../core.dart';

/// Responsible for transforming raw [Response] data into structured [BaseResponse] objects.
class Parser {
  
  /// Parses a generic [Response] into a [BaseResponse] of type [T].
  /// 
  /// Uses a [ResponseMapper] to handle the conversion of the 'data' field.
  /// Automatically extracts 'status', 'message', and 'pagination' from the JSON.
  static Future<Either<AppException, BaseResponse<T>>> parseBaseResponse<T>(
      Response response, ResponseMapper<T> mapper) async {
    try {
      final json = Map<String, dynamic>.from(response.data);

      final bool status = json['status'] ?? false;
      final String message = json['message'] ?? '';

      // If server explicitly returns status: false, treat as ValidationError
      if (!status) {
        return Left(ValidationError(message: message));
      }

      final rawData =
      (json['data'] == null || json['data'].isEmpty) ? null : json['data'];
      final rawPagination = json['pagination'];

      // Perform mapping of the main payload
      final parsedData = rawData == null ? null : mapper.fromJson(rawData);
      
      // Parse pagination if present
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
