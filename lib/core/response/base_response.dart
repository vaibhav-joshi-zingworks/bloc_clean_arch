
import '../../core.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

/// The standard envelope for all API responses in the project.
/// 
/// [T] represents the type of the 'data' field payload.
@Freezed(genericArgumentFactories: true)
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({
    /// Indicates if the request was successful from a business perspective.
    required bool status, 
    
    /// User-facing message returned by the server.
    required String message, 
    
    /// The actual payload of the response.
    T? data, 
    
    /// Optional pagination info for list-based responses.
    Pagination? pagination
  }) = _BaseResponse<T>;

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);
}
