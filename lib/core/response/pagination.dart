import '../../core.dart';

/// Data class representing pagination metadata returned from the API.
class Pagination extends Equatable {
  /// Total number of records available across all pages.
  final int total;
  
  /// The current page number (usually 1-indexed).
  final int page;
  
  /// Number of items per page.
  final int limit;
  
  /// Total number of pages available.
  final int totalPages;

  const Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  /// Creates a [Pagination] from a JSON map.
  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'] as int,
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
    );
  }

  /// Converts the [Pagination] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
    };
  }

  @override
  List<Object?> get props => [total, page, limit, totalPages];
}
