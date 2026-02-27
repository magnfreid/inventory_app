import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_authentication_service/firebase_authentication_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user_remote/firebase_user_remote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/app/bloc_observer.dart';
import 'package:inventory_app/app/view/app.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/firebase_options.dart';
import 'package:inventory_app/theme/cubit/theme_cubit.dart';
import 'package:user_repository/user_repository.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final firebaseUserRemote = FirebaseUserRemote();
  final authService = FirebaseAuthenticationService();
  final userRepository = UserRepository(remote: firebaseUserRemote);
  final authCubit = AuthenticationCubit(
    authService: authService,
  );
  final themeCubit = ThemeCubit();

  runApp(
    App(
      authService: authService,
      userRepository: userRepository,
      authCubit: authCubit,
      themeCubit: themeCubit,
    ),
  );
}
