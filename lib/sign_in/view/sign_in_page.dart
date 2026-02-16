import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(authRepository: context.read<AuthRepository>()),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: .center,
            children: [
              const Spacer(),
              TextField(
                decoration: const InputDecoration(label: Text('Email')),
                controller: _emailTextController,
              ),
              TextField(
                decoration: const InputDecoration(label: Text('Password')),
                controller: _passwordTextController,
              ),
              const Spacer(),
              //TODO(magnfreid): l10n!!!
              ElevatedButton(
                onPressed: () => context.read<SignInBloc>().add(
                  SignInButtonPressed(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  ),
                ),
                child: state.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Text('Sign in'),
              ),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
