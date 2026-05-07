
import '../../core.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

/// Data class representing pagination metadata returned from the API.
@freezed
abstract class Pagination with _$Pagination {
  const factory Pagination({
    /// Total number of records available across all pages.
    required int total, 
    
    /// The current page number (usually 1-indexed).
    required int page, 
    
    /// Number of items per page.
    required int limit, 
    
    /// Total number of pages available.
    required int totalPages
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) => _$PaginationFromJson(json);
}
