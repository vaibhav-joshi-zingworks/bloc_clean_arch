import 'package:bloc_clean_arch/core/response/pagination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pagination', () {
    test('fromJson should correctly parse pagination data', () {
      final json = {
        'total': 100,
        'page': 1,
        'limit': 10,
        'totalPages': 10,
      };

      final pagination = Pagination.fromJson(json);

      expect(pagination.total, 100);
      expect(pagination.page, 1);
      expect(pagination.limit, 10);
      expect(pagination.totalPages, 10);
    });

    test('toJson should return a valid map', () {
      const pagination = Pagination(
        total: 50,
        page: 2,
        limit: 5,
        totalPages: 10,
      );
      final json = pagination.toJson();

      expect(json['total'], 50);
      expect(json['page'], 2);
      expect(json['limit'], 5);
      expect(json['totalPages'], 10);
    });
  });
}
