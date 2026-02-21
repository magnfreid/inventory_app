import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
import 'package:inventory_app/authentication/view/authenticaton_page.dart';
import 'package:inventory_app/home/view/home_page.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_repository/user_repository.dart';

import '../../helpers/helpers.dart';

void main() {
  late AuthenticationCubit authenticationCubit;
  late AuthRepository authRepository;
  late UserRepository userRepository;

  setUp(() {
    authenticationCubit = MockAuthenticationCubit();
    authRepository = MockAuthRepository();
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
              value: authRepository,
            ),
            RepositoryProvider.value(
              value: userRepository,
            ),
          ],
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const AuthenticationPage(),
          ),
        ),
      );

      expect(find.byType(SignInPage), findsOneWidget);
    },
  );

  testWidgets(
    'renders HomePage when authenticated and user loads',
    (tester) async {
      final authUser = AuthUser(id: '123');

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
            RepositoryProvider.value(value: authRepository),
            RepositoryProvider.value(value: userRepository),
          ],
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const AuthenticationPage(),
          ),
        ),
      );

      await tester.pump(); // allow UserCubit to emit loaded
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    },
  );

  testWidgets(
    'calls signOut() when logout button is pressed',
    (tester) async {
      when(
        () => authenticationCubit.state,
      ).thenReturn(const .unauthenticated());
      whenListen(
        authenticationCubit,
        const Stream<AuthenticationState>.empty(),
      );

      when(() => authenticationCubit.signOut()).thenAnswer((_) async {});

      await tester.pumpApp(
        RepositoryProvider.value(
          value: authRepository,
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const AuthenticationPage(),
          ),
        ),
      );
      await tester.tap(find.byIcon(Icons.logout));
      await tester.pump();
      verify(
        () => authenticationCubit.signOut(),
      ).called(1);
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
          value: authRepository,
          child: BlocProvider.value(
            value: authenticationCubit,
            child: const AuthenticationPage(),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
