import 'package:authentication_service/authentication_service.dart';
import 'package:core_remote/core_remote.dart';
import 'package:firebase_auth/firebase_auth.dart';

///Implementation of [AuthenticationService] that authenticates users via
/// Firebase Auth.
class FirebaseAuthenticationService implements AuthenticationService {
  ///Creates a [FirebaseAuthenticationService]. Takes in an optional
  /// [FirebaseAuth] instance (used for testing).
  FirebaseAuthenticationService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthenticatedUser?> get currentUser =>
      _firebaseAuth.authStateChanges().map((user) {
        return user == null ? null : AuthenticatedUser(id: user.uid);
      }).distinct();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapAuthException(e);
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// Maps a [FirebaseAuthException] to an app-specific [RemoteException].
  RemoteException _mapAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
      case 'invalid-email':
      case 'user-not-found':
        return const InvalidCredentialsException();
      case 'user-disabled':
        return const PermissionDeniedException();
      case 'network-request-failed':
        return const NetworkException();
      default:
        return const UnknownRemoteException();
    }
  }
}
