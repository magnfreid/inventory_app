part of 'sign_in_bloc.dart';

sealed class SignInEvent {}

final class SignInButtonPressed extends SignInEvent {
  SignInButtonPressed({required this.email, required this.password});
  final String email;
  final String password;
}
