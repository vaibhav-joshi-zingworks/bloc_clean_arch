import '../response/pagination.dart';

class PaginatedResult<T> {
  final String? message;
  final List<T> items;
  final Pagination? pagination;

  const PaginatedResult({required this.items, this.pagination, this.message});

  bool get hasNextPage {
    if (pagination == null) return false;
    return pagination!.page < pagination!.totalPages;
  }
}
