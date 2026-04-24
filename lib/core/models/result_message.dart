import '../../core.dart';

part 'result_message.freezed.dart';
part 'result_message.g.dart';

@freezed
sealed class ResultMessage with _$ResultMessage {
  const factory ResultMessage({required String message}) = _ResultMessage;

  factory ResultMessage.fromJson(Map<String, dynamic> json) =>
      _$ResultMessageFromJson(json);
}
