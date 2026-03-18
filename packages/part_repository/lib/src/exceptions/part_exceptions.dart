sealed class PartException implements Exception {
  const PartException();
}

class PartPermissionDenied extends PartException {
  const PartPermissionDenied();
}

class PartNotFound extends PartException {
  const PartNotFound();
}

class PartAlreadyExists extends PartException {
  const PartAlreadyExists();
}

class PartNetworkError extends PartException {
  const PartNetworkError();
}

class PartTimeout extends PartException {
  const PartTimeout();
}

class PartUnknownError extends PartException {
  const PartUnknownError(this.message);
  final String message;
}
