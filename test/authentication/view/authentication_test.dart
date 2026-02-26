import 'package:authentication_service/authentication_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authenticated_app/view/authenticated_app.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/authentication/view/authentication.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late AuthenticationCubit authenticationCubit;
  late AuthenticationService authService;
  late UserRepository userRepository;

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();
    authService = MockAuthRepository();
    userRepository = MockUserRepository();
  });

  testWidgets(
    'renders SignInPage when unauthenticated',
    (tester) async {
      whenListen(
        authenticationCubit,
        Stream<AuthenticationState>.fromIterable([
          const .unauthenticated(),
        ]),
        initialState: const AuthenticationState.unauthenticated(),
      );

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: authService,
            ),
            RepositoryProvider.value(
              value: userRepository,
            ),
          ],
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const Authentication(),
          ),
        ),
      );

      expect(find.byType(SignInPage), findsOneWidget);
    },
  );

  testWidgets(
    'renders AuthenticatedApp when authenticated',
    (tester) async {
      final authUser = AuthenticatedUser(id: '123');

      final user = User(
        id: '123',
        organizationId: 'org1',
        name: 'name',
        email: 'email',
        role: .admin,
      );

      whenListen(
        authenticationCubit,
        Stream<AuthenticationState>.fromIterable([
          AuthenticationState.authenticated(user: authUser),
        ]),
        initialState: AuthenticationState.authenticated(user: authUser),
      );

      when(
        () => userRepository.watchUser(authUser.id),
      ).thenAnswer((_) => Stream.value(user));

      await tester.pumpApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(value: authService),
            RepositoryProvider.value(value: userRepository),
          ],
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const Authentication(),
          ),
        ),
      );

      expect(find.byType(AuthenticatedApp), findsOneWidget);
    },
  );

  testWidgets(
    'renders CircularProgressIndicator when loading',
    (tester) async {
      when(
        () => authenticationCubit.state,
      ).thenReturn(const .loading());
      whenListen(
        authenticationCubit,
        Stream<AuthenticationState>.fromIterable([
          const .loading(),
        ]),
        initialState: const AuthenticationState.loading(),
      );
      await tester.pumpApp(
        RepositoryProvider.value(
          value: authService,
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const Authentication(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
