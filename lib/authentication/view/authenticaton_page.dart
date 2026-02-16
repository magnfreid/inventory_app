import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/bloc/authentication_bloc.dart';
import 'package:inventory_app/authentication/bloc/authentication_state.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return state.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              unauthenticated: () => const SignInPage(),
              authenticated: (user) => Center(child: Text(user.id)),
            );
          },
        ),
      ),
    );
  }
}
