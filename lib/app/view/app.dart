import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_app/app/app_themes.dart';
import 'package:inventory_app/app/cubit/authentication_cubit.dart';
import 'package:inventory_app/l10n/gen/app_localizations.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required AuthenticationCubit authGateCubit,
    required GoRouter router,
    super.key,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _authGateCubit = authGateCubit,
       _router = router;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthenticationCubit _authGateCubit;
  final GoRouter _router;

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
            value: _authGateCubit,
          ),
        ],
        child: AppView(router: _router),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: AppThemes.lightTheme(context),
      darkTheme: AppThemes.darkTheme(context),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
