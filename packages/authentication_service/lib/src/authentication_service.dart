import 'package:authentication_service/authentication_service.dart';

abstract interface class AuthenticationService {
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Stream<AuthenticatedUser?> get currentUser;

  Future<void> signOut();
}
