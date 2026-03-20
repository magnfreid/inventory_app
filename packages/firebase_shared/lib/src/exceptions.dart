import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_remote/core_remote.dart';

/// A function that maps [FirebaseException]'s to [RemoteException]'s.
RemoteException mapFirebaseException(FirebaseException e) {
  switch (e.code) {
    case 'permission-denied':
      return const PermissionDeniedException();

    case 'not-found':
      return const NotFoundException();

    case 'already-exists':
      return const AlreadyExistsException();

    case 'unavailable':
    case 'deadline-exceeded':
      return const NetworkException();

    case 'user-not-found':
      return const NotFoundException();
    case 'email-already-in-use':
      return const AlreadyExistsException();
    case 'wrong-password':
    case 'invalid-credential':
      return const PermissionDeniedException();

    case 'file-not-found':
      return const NotFoundException();
    case 'unauthorized':
      return const PermissionDeniedException();

    default:
      return const UnknownRemoteException();
  }
}

/// Getter for [InvalidArgumentRemoteException]. Used because this error needs
/// to be thrown by custom validation logic and would otherwise be unreachable
/// through firebase_shared package.
InvalidArgumentRemoteException get invalidArgument =>
    const InvalidArgumentRemoteException();
