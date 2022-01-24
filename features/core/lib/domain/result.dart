/// A generic class that holds a value with its loading status.
/// @param <T>
///*/
abstract class Result<T> {
  @override
  String toString() {
    switch (runtimeType) {
      case Success:
        return (this as Success).data.toString();
      default:
        return (this as Error).exception.toString();
    }
  }
}

class Success<T> implements Result<T> {
  T data;

  Success(this.data);
}

class Error<T> implements Result<T> {
  Exception exception;

  Error(this.exception);

  @override
  String toString() {
    return exception.toString();
  }
}

/// `true` if [Result] is of type [Success] & holds non-null [Success.data].
///*/
extension ResultExtension<T> on Result<T> {
  bool succeeded() {
    return this is Success && (this as Success).data != null;
  }

  /// return data if result is Success and throw exception otherwise.
  ///*/
  T getDataIfSuccess() {
    if (succeeded()) {
      return (this as Success<T>).data;
    } else {
      print(toString());
      throw Exception("Cannot cast result to success");
    }
  }

  String getErrorMessage() {
    if (!succeeded()) {
      return (this as Error<T>).exception.toString();
    } else {
      throw Exception("Cannot cast result to Error");
    }
  }
}
