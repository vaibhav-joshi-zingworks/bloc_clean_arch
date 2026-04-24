
import '../../../core.dart';

abstract class ResponseMapper<T> {
  T fromJson(dynamic json);
}

class ObjectMapper<T> extends ResponseMapper<T> {
  final T Function(Map<String, dynamic>) parser;

  ObjectMapper(this.parser);

  @override
  T fromJson(dynamic json) {
    return parser(json as Map<String, dynamic>);
  }
}

class ListMapper<T> extends ResponseMapper<List<T>> {
  final T Function(Map<String, dynamic>) parser;

  ListMapper(this.parser);

  @override
  List<T> fromJson(dynamic json) {
    final list = json as List;
    return list.map((e) => parser(e as Map<String, dynamic>)).toList();
  }
}

class PaginatedMapper<T> extends ResponseMapper<PaginatedResult<T>> {
  final T Function(Map<String, dynamic>) parser;
  PaginatedMapper(this.parser);

  @override
  PaginatedResult<T> fromJson(dynamic json) {
    final list = (json as List).map((e) => parser(e as Map<String, dynamic>)).toList();
    return PaginatedResult<T>(items: list);
  }
}

class ResultMapper<T> extends ResponseMapper<Result<T>> {
  final T Function(Map<String, dynamic>) parser;

  ResultMapper(this.parser);

  @override
  Result<T> fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      if (json.containsKey('data') && json['data'] != null) {
        final data = parser(json['data'] as Map<String, dynamic>);
        final message = json['message'] as String?;
        return Result<T>(data: data, message: message);
      }

      if (json.containsKey('message') && json['message'] != null) {
        return Result<T>(data: null, message: json['message'] as String);
      }
    }

    return Result<T>();
  }
}
