import '../../core.dart';

/// Represents a simple message-only response from the domain/data layer.
class ResultMessage extends Equatable {
  /// The message string returned by the API or service.
  final String message;

  const ResultMessage({
    required this.message,
  });

  /// Creates a [ResultMessage] from a JSON map.
  factory ResultMessage.fromJson(Map<String, dynamic> json) {
    return ResultMessage(
      message: json['message'] as String,
    );
  }

  /// Converts the [ResultMessage] into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  @override
  List<Object?> get props => [message];
}
