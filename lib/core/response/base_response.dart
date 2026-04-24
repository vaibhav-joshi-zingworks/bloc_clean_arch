
import '../../core.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class BaseResponse<T> with _$BaseResponse<T> {
  const factory BaseResponse({required bool status, required String message, T? data, Pagination? pagination}) = _BaseResponse<T>;

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) => _$BaseResponseFromJson(json, fromJsonT);
}
