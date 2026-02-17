part of 'sign_in_bloc.dart';

sealed class SignInEvent {
  const SignInEvent();
}

final class SignInButtonPressed extends SignInEvent {
  const SignInButtonPressed({required this.email, required this.password});
  final String email;
  final String password;
}
