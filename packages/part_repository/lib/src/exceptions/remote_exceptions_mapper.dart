import 'package:core_remote/core_remote.dart';
import 'package:part_repository/src/exceptions/part_exceptions.dart';

PartException mapRemoteToRepositoryException(RemoteException e) {
  return switch (e) {
    PermissionDeniedException() => const PartPermissionDenied(),
    NotFoundException() => const PartNotFound(),
    AlreadyExistsException() => const PartAlreadyExists(),
    NetworkException() => const PartNetworkError(),
    TimeoutException() => const PartTimeout(),
    UnknownRemoteException() => PartUnknownError(e.message),
  };
}
