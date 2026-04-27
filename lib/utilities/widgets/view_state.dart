sealed class ViewState<T> {
  const ViewState();
}

class Loading<T> extends ViewState<T> {
  const Loading();
}

class Error<T> extends ViewState<T> {
  final Object error;

  const Error(this.error);
}

class Data<T> extends ViewState<T> {
  final T value;

  const Data(this.value);
}