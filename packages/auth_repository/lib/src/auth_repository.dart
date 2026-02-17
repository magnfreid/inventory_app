import 'package:auth_repository/src/models/auth_user.dart';

abstract interface class AuthRepository {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Stream<AuthUser?> get currentUser;

  Future<void> signOut();
}
