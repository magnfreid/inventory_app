import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_app/app/cubit/authentication_cubit.dart';
import 'package:inventory_app/app/cubit/authentication_state.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';

import 'package:inventory_app/sign_in/view/sign_in_page.dart';

GoRouter createGoRouter(AuthenticationCubit authCubit) => GoRouter(
  initialLocation: '/splash',
  refreshListenable: GoRouterRefreshStream(authCubit.stream),
  redirect: (context, state) {
    final authState = authCubit.state;
    final goingToLogin = state.uri.path == '/sign-in';

    return authState.when(
      loading: () => state.uri.path == '/splash' ? null : '/splash',
      unauthenticated: () => goingToLogin ? null : '/sign-in',
      authenticated: (_) =>
          state.uri.path == '/sign-in' || state.uri.path == '/splash'
          ? '/'
          : null,
    );
  },
  routes: [
    GoRoute(
      path: '/splash',
      builder: (_, _) => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        final authUser = context.read<AuthenticationCubit>().state.maybeWhen(
          authenticated: (u) => u,
          orElse: () => null,
        );

        return AuthenticatedApp(currentUserId: authUser!.id);
      },
    ),
    GoRoute(
      path: '/sign-in',
      builder: (_, _) => const SignInPage(),
    ),
    GoRoute(path: '/details'),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (_) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  Future<void> dispose() async {
    await _subscription.cancel();
    super.dispose();
  }
}
