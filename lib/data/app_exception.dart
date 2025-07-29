class AppException implements Exception {
  final String? _message;
  final String? _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super(message, 'No internet');
}

class RequestTimeoutException extends AppException {
  RequestTimeoutException([String? message])
    : super(message, 'Request timeout');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Internal server error');
}
