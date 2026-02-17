import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthUser?> get currentUser =>
      _firebaseAuth.authStateChanges().map((user) {
        return user == null ? null : AuthUser(id: user.uid);
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
