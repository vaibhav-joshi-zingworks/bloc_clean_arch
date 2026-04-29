import 'package:bloc_clean_arch/core/response/mappers/response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ObjectMapper', () {
    test('should map json to object', () {
      final mapper = ObjectMapper<int>((json) => json['id'] as int);
      expect(mapper.fromJson({'id': 1}), 1);
    });
  });

  group('ListMapper', () {
    test('should map json list to list of objects', () {
      final mapper = ListMapper<int>((json) => json['id'] as int);
      expect(mapper.fromJson([{'id': 1}, {'id': 2}]), [1, 2]);
    });
  });

  group('ResultMapper', () {
    test('should map json to Result with data and message', () {
      final mapper = ResultMapper<int>((json) => json['val'] as int);
      final json = {
        'data': {'val': 10},
        'message': 'success'
      };
      final result = mapper.fromJson(json);
      expect(result.data, 10);
      expect(result.message, 'success');
    });

    test('should map json with only message', () {
      final mapper = ResultMapper<int>((json) => 0);
      final json = {'message': 'error message'};
      final result = mapper.fromJson(json);
      expect(result.data, isNull);
      expect(result.message, 'error message');
    });
  });
}
