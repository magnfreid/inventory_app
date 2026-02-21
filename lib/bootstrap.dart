import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_user_repository/firebase_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/app/bloc_observer.dart';
import 'package:inventory_app/app/view/app.dart';
import 'package:inventory_app/authentication_gate/cubits/auth/authentication_cubit.dart';
import 'package:inventory_app/firebase_options.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  final authRepository = FirebaseAuthRepository();
  final userRepository = FirebaseUserRepository();
  final authCubit = AuthenticationCubit(
    authRepository: authRepository,
  );
  // final router = createGoRouter(authCubit);

  runApp(
    App(
      authRepository: authRepository,
      userRepository: userRepository,
      authCubit: authCubit,
    ),
  );
}
