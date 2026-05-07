import '../../core.dart';

part 'result_message.freezed.dart';
part 'result_message.g.dart';

/// Represents a simple message-only response from the domain/data layer.
@freezed
sealed class ResultMessage with _$ResultMessage {
  const factory ResultMessage({
    /// The message string returned by the API or service.
    required String message,
  }) = _ResultMessage;

  factory ResultMessage.fromJson(Map<String, dynamic> json) =>
      _$ResultMessageFromJson(json);
}
