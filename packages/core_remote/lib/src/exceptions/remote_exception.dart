sealed class RemoteException implements Exception {
  const RemoteException();
}

class PermissionDeniedException extends RemoteException {
  const PermissionDeniedException();
}

class NotFoundException extends RemoteException {
  const NotFoundException();
}

class AlreadyExistsException extends RemoteException {
  const AlreadyExistsException();
}

class NetworkException extends RemoteException {
  const NetworkException();
}

class TimeoutException extends RemoteException {
  const TimeoutException();
}

class UnknownRemoteException extends RemoteException {
  const UnknownRemoteException(this.message);
  final String message;
}
