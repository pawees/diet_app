class ErrorConnection implements Exception {
  ErrorConnection(String error);
}

class ErrorCredentials implements Exception {
  ErrorCredentials(String error);
}

class ErrorSendOrder implements Exception {
  ErrorSendOrder(String error);
  String? error;
}
