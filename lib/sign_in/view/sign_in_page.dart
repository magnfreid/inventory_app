import 'package:app_ui/app_ui.dart';
import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/l10n/l10n.dart';
import 'package:inventory_app/shared/extensions/show_snack_bar_extensions.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SignInBloc(authService: context.read<AuthenticationService>()),
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
    final l10n = context.l10n;
    return BlocListener<SignInBloc, SignInState>(
      listenWhen: (previous, current) => current.error != null,
      listener: (context, state) {
        context.showErrorSnackBar(state.error!);
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const .symmetric(horizontal: 50),
              child: Column(
                spacing: 10,
                children: [
                  const Spacer(),
                  TextFormField(
                    decoration: InputDecoration(
                      label: Text(l10n.signInEmailTextFieldLabel),
                    ),
                    controller: _emailTextController,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(l10n.signInPasswordTextFieldLabel),
                    ),
                    controller: _passwordTextController,
                  ),
                  const Spacer(),
                  AppButton(
                    width: .wide,
                    isLoading: state.isLoading,
                    onPressed: () => context.read<SignInBloc>().add(
                      SignInButtonPressed(
                        email: _emailTextController.text,
                        password: _passwordTextController.text,
                      ),
                    ),
                    label: l10n.signInSignInButtonText,
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
