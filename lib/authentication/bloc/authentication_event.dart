part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class _OnUserChanged extends AuthenticationEvent {
  _OnUserChanged({required this.newUser});
  final AuthUser? newUser;
}

final class SignOutButtonPressed extends AuthenticationEvent {}
