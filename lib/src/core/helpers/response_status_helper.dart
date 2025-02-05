sealed class ResponseStatusHelper<T> {
  const ResponseStatusHelper();
}

class Success<T> extends ResponseStatusHelper<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends ResponseStatusHelper<T> {
  final String message;
  final int? statusCode;
  final dynamic error;

  const Failure({required this.message, this.statusCode, this.error});
}

class Loading<T> extends ResponseStatusHelper<T> {
  const Loading();
}
