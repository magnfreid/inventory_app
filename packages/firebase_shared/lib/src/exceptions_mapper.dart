import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_remote/core_remote.dart';

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
