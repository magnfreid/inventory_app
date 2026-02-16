import 'package:auth_repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Stream<AuthUser?> get currentUser => auth.authStateChanges().map((user) {
    return user == null ? null : AuthUser(id: user.uid);
  }).distinct();

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
