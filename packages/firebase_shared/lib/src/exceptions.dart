import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core_remote/core_remote.dart';

export 'package:core_remote/core_remote.dart';

/// A function that maps [FirebaseException]'s to [RemoteException]'s.
RemoteException mapFirebaseException(FirebaseException e) {
  log(e.toString());
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

    case 'file-not-found':
      return const NotFoundException();
    case 'unauthorized':
      return const PermissionDeniedException();

    default:
      return const UnknownRemoteException();
  }
}
