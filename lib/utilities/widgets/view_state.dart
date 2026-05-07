/// A sealed class representing the different states a view can be in.
/// 
/// This is typically used in conjunction with Cubits or BLoCs to emit 
/// states that the UI can easily switch between.
sealed class ViewState<T> {
  const ViewState();
}

/// State indicating that data is currently being fetched or processed.
class Loading<T> extends ViewState<T> {
  const Loading();
}

/// State indicating that an error occurred, containing the [error] object.
class Error<T> extends ViewState<T> {
  final Object error;

  const Error(this.error);
}

/// State indicating that data has been successfully retrieved or processed.
class Data<T> extends ViewState<T> {
  /// The resulting value of type [T].
  final T value;

  const Data(this.value);
}