
import '../../../core.dart';

/// Abstract base class for mapping dynamic JSON data into structured objects.
abstract class ResponseMapper<T> {
  /// Transforms the input [json] into an instance of [T].
  T fromJson(dynamic json);
}

/// Mapper for a single object.
class ObjectMapper<T> extends ResponseMapper<T> {
  final T Function(Map<String, dynamic>) parser;

  ObjectMapper(this.parser);

  @override
  T fromJson(dynamic json) {
    return parser(json as Map<String, dynamic>);
  }
}

/// Mapper for a simple list of objects.
class ListMapper<T> extends ResponseMapper<List<T>> {
  final T Function(Map<String, dynamic>) parser;

  ListMapper(this.parser);

  @override
  List<T> fromJson(dynamic json) {
    final list = json as List;
    return list.map((e) => parser(e as Map<String, dynamic>)).toList();
  }
}

/// Mapper for paginated list responses.
class PaginatedMapper<T> extends ResponseMapper<PaginatedResult<T>> {
  final T Function(Map<String, dynamic>) parser;
  PaginatedMapper(this.parser);

  @override
  PaginatedResult<T> fromJson(dynamic json) {
    final list = (json as List).map((e) => parser(e as Map<String, dynamic>)).toList();
    return PaginatedResult<T>(items: list);
  }
}

/// Mapper for responses that follow the [Result] pattern (message + optional data).
class ResultMapper<T> extends ResponseMapper<Result<T>> {
  final T Function(Map<String, dynamic>) parser;

  ResultMapper(this.parser);

  @override
  Result<T> fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      // Handle responses where data is nested
      if (json.containsKey('data') && json['data'] != null) {
        final data = parser(json['data'] as Map<String, dynamic>);
        final message = json['message'] as String?;
        return Result<T>(data: data, message: message);
      }

      // Handle message-only responses
      if (json.containsKey('message') && json['message'] != null) {
        return Result<T>(data: null, message: json['message'] as String);
      }
    }

    return Result<T>();
  }
}
