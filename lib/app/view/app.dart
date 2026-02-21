import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/app/app_themes.dart';
import 'package:inventory_app/authentication_gate/cubits/auth/authentication_cubit.dart';
import 'package:inventory_app/authentication_gate/view/authentication_gate.dart';
import 'package:inventory_app/l10n/gen/app_localizations.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required AuthenticationCubit authCubit,
    super.key,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _authCubit = authCubit;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthenticationCubit _authCubit;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _authCubit,
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme(context),
      darkTheme: AppThemes.darkTheme(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AuthenticationGate(),
    );
  }
}
