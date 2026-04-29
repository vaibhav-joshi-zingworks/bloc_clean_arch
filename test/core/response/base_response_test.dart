import 'package:bloc_clean_arch/core/response/base_response.dart';
import 'package:bloc_clean_arch/core/response/pagination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BaseResponse', () {
    test('fromJson should parse correctly', () {
      final json = {
        'status': true,
        'message': 'Success',
        'data': 'test data',
        'pagination': {
          'total': 100,
          'page': 1,
          'limit': 10,
          'totalPages': 10,
        }
      };

      final response = BaseResponse<String>.fromJson(
        json,
        (data) => data as String,
      );

      expect(response.status, true);
      expect(response.message, 'Success');
      expect(response.data, 'test data');
      expect(response.pagination?.total, 100);
    });
  });

  group('Pagination', () {
    test('fromJson should parse correctly', () {
      final json = {
        'total': 50,
        'page': 2,
        'limit': 5,
        'totalPages': 10,
      };

      final pagination = Pagination.fromJson(json);

      expect(pagination.total, 50);
      expect(pagination.page, 2);
      expect(pagination.limit, 5);
      expect(pagination.totalPages, 10);
    });
  });
}
