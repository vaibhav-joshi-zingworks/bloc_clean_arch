import 'package:bloc_clean_arch/core/models/paginated_result.dart';
import 'package:bloc_clean_arch/core/response/pagination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaginatedResult', () {
    test('hasNextPage should be true if current page < total pages', () {
      const pagination = Pagination(total: 10, page: 1, limit: 5, totalPages: 2);
      const result = PaginatedResult<String>(items: [], pagination: pagination);
      expect(result.hasNextPage, true);
    });

    test('hasNextPage should be false if current page == total pages', () {
      const pagination = Pagination(total: 10, page: 2, limit: 5, totalPages: 2);
      const result = PaginatedResult<String>(items: [], pagination: pagination);
      expect(result.hasNextPage, false);
    });

    test('hasNextPage should be false if pagination is null', () {
      const result = PaginatedResult<String>(items: []);
      expect(result.hasNextPage, false);
    });
  });
}
