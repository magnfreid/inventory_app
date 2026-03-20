/// Base class for all exceptions originating from remote data sources,
/// such as APIs, databases, or network services.
///
/// These exceptions represent failures that occur outside the local
/// application and should typically be mapped to user-friendly messages.
sealed class RemoteException implements Exception {
  /// Creates a [RemoteException]
  const RemoteException();
}

/// Thrown when the current user does not have permission to perform
/// the requested operation.
///
/// Example: attempting to modify a resource without sufficient access rights.
class PermissionDeniedException extends RemoteException {
  /// Creates a [PermissionDeniedException]
  const PermissionDeniedException();
}

/// Thrown when a requested resource could not be found on the remote source.
///
/// Example: fetching a document or entity that does not exist.
class NotFoundException extends RemoteException {
  /// Creates a [NotFoundException]
  const NotFoundException();
}

/// Thrown when attempting to create a resource that already exists.
///
/// Example: creating a user or item with an ID that is already in use.
class AlreadyExistsException extends RemoteException {
  /// Creates a [AlreadyExistsException]
  const AlreadyExistsException();
}

/// Thrown when a network-related issue prevents the request from completing.
///
/// Example: no internet connection or unstable connectivity.
class NetworkException extends RemoteException {
  /// Creates a [NetworkException]
  const NetworkException();
}

/// Thrown when a remote request exceeds the allowed time limit.
///
/// Example: the server takes too long to respond.
class TimeoutException extends RemoteException {
  /// Creates a [TimeoutException]
  const TimeoutException();
}

/// Thrown when an unknown or unexpected error occurs in the remote layer.
///
/// This is typically used as a fallback when no specific exception
/// type matches the failure.
class UnknownRemoteException extends RemoteException {
  ///Creates an [UnknownRemoteException]
  const UnknownRemoteException();
}

/// Thrown when the provided input or arguments are invalid.
///
/// This usually indicates a validation error, such as:
/// - invalid number formats
/// - out-of-range values
/// - missing required fields
///
/// Note: This differs from [AlreadyExistsException] and [NotFoundException],
/// which relate to resource state rather than input validity.
class InvalidArgumentRemoteException extends RemoteException {
  ///Creates an [InvalidArgumentRemoteException]
  const InvalidArgumentRemoteException();
}
