import 'package:app_ui/app_ui.dart';
import 'package:authentication_service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/view/authentication.dart';
import 'package:inventory_app/l10n/gen/app_localizations.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    required AuthenticationService authService,
    required UserRepository userRepository,
    required AuthenticationCubit authCubit,
    required ThemeCubit themeCubit,
    super.key,
  }) : _authService = authService,
       _userRepository = userRepository,
       _authCubit = authCubit,
       _themeCubit = themeCubit;

  final AuthenticationService _authService;
  final UserRepository _userRepository;
  final AuthenticationCubit _authCubit;
  final ThemeCubit _themeCubit;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authService),
        RepositoryProvider.value(value: _userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authCubit),
          BlocProvider.value(value: _themeCubit),
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
    final themeMode = context.watch<ThemeCubit>().state;
    return MaterialApp(
      themeMode: themeMode,
      theme: AppTheme.light().themeData,
      darkTheme: AppTheme.dark().themeData,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const Authentication(),
    );
  }
}
