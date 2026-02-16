import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  @override
  void initState() {
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Spacer(),
          if (Platform.isIOS)
            CupertinoTextField(
              controller: _emailTextController,
              placeholder: 'Email',
            )
          else
            TextField(
              decoration: const InputDecoration(label: Text('Email')),
              controller: _emailTextController,
            ),
          if (Platform.isIOS)
            CupertinoTextField(
              controller: _passwordTextController,
              placeholder: 'Password',
            )
          else
            TextField(
              decoration: const InputDecoration(label: Text('Password')),
              controller: _passwordTextController,
            ),
          const Spacer(),
          //TODO(magnfreid): l10n!!!
          if (Platform.isIOS)
            CupertinoButton(child: const Text('Sign in'), onPressed: () {})
          else
            ElevatedButton(onPressed: () {}, child: const Text('Sign in')),
          const Spacer(),
        ],
      ),
    );
  }
}
