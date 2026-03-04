import 'package:authentication_service/authentication_service.dart';

///Interface for the app's Authentication Service that handles signing in and
///out and the current authentication state.
abstract interface class AuthenticationService {
  ///Used to authenticated a user via email and password.
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  ///A stream that emits an [AuthenticatedUser] if authenticated or null if
  /// unauthenticated.
  Stream<AuthenticatedUser?> get currentUser;

  ///Used to sign out a user.
  Future<void> signOut();
}
