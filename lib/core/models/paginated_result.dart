import '../response/pagination.dart';

/// A generic wrapper for list-based data that includes pagination metadata.
class PaginatedResult<T> {
  /// Feedback message from the operation.
  final String? message;
  
  /// The list of data items for the current page.
  final List<T> items;
  
  /// Metadata about total pages, current page, and records.
  final Pagination? pagination;

  const PaginatedResult({required this.items, this.pagination, this.message});

  /// Logic to determine if more data can be fetched.
  bool get hasNextPage {
    if (pagination == null) return false;
    return pagination!.page < pagination!.totalPages;
  }
}
