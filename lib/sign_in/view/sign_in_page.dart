import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
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
    _emailTextController = TextEditingController(text: 'test@test.com');
    _passwordTextController = TextEditingController(text: 'testpassword');
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
    final l10n = context.l10n;
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) => current.error != null,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(state.error.toString()),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: .center,
                children: [
                  const Spacer(),
                  TextField(
                    decoration: InputDecoration(
                      label: Text(l10n.signInEmailTextFieldLabel),
                    ),
                    controller: _emailTextController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      label: Text(l10n.signInPasswordTextFieldLabel),
                    ),
                    controller: _passwordTextController,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => context.read<SignInBloc>().add(
                        SignInButtonPressed(
                          email: _emailTextController.text,
                          password: _passwordTextController.text,
                        ),
                      ),
                      child: state.isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Text(l10n.signInSignInButtonText),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
