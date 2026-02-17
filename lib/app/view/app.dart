import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/bloc/authentication_bloc.dart';
import 'package:inventory_app/authentication/view/authenticaton_page.dart';
import 'package:inventory_app/l10n/gen/app_localizations.dart';

class App extends StatelessWidget {
  const App({required AuthRepository authRepository, super.key})
    : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(authRepository: _authRepository),
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Scaffold(body: AuthenticationPage()),
    );
  }
}
