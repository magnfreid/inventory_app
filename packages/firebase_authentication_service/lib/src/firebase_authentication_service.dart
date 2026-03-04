import 'package:authentication_service/authentication_service.dart';
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
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
