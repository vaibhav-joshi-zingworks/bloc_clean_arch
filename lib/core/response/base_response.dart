import '../../core.dart';

/// The standard envelope for all API responses in the project.
/// 
/// [T] represents the type of the 'data' field payload.
class BaseResponse<T> extends Equatable {
  /// Indicates if the request was successful from a business perspective.
  final bool status;
  
  /// User-facing message returned by the server.
  final String message;
  
  /// The actual payload of the response.
  final T? data;
  
  /// Optional pagination info for list-based responses.
  final Pagination? pagination;

  const BaseResponse({
    required this.status,
    required this.message,
    this.data,
    this.pagination,
  });

  /// Creates a [BaseResponse] from a JSON map, providing a [fromJsonT] 
  /// callback to parse the generic data payload.
  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return BaseResponse<T>(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: json['data'] == null ? null : fromJsonT(json['data']),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [status, message, data, pagination];
}
