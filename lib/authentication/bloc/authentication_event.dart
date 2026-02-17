part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class _OnUserChanged extends AuthenticationEvent {
  const _OnUserChanged({required this.newUser});
  final AuthUser? newUser;
}

final class SignOutButtonPressed extends AuthenticationEvent {
  const SignOutButtonPressed();
}
