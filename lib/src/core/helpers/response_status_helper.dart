sealed class ResponseStatusHelper<T> {
  const ResponseStatusHelper();
}

class Success extends ResponseStatusHelper {
  final dynamic data;

  const Success(this.data);
}

class Failure extends ResponseStatusHelper {
  final String message;
  final int? statusCode;
  final dynamic error;

  const Failure({required this.message, this.statusCode, this.error});
}

class Loading extends ResponseStatusHelper {
  const Loading();
}
