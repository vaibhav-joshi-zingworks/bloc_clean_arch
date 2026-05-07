/// A simple generic wrapper for operation outcomes.
/// 
/// Usually used when a response contains a message and a single data object.
class Result<T> {
  /// Feedback message from the operation (success or warning).
  final String? message;
  
  /// The actual payload of the result.
  final T? data;

  const Result({this.data, this.message});
}
