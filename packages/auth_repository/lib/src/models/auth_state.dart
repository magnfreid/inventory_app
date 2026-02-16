import 'package:auth_repository/src/models/auth_user.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState {
  const AuthState({required this.status, this.user});
  final AuthStatus status;
  final AuthUser? user;
}
