import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authentication/bloc/authentication_bloc.dart';
import 'package:inventory_app/authentication/bloc/authentication_state.dart';
import 'package:inventory_app/authentication/view/authenticaton_page.dart';
import 'package:inventory_app/home/view/home_page.dart';
import 'package:inventory_app/sign_in/view/sign_in_page.dart';

import '../../helpers/helpers.dart';

void main() {
  late AuthenticationBloc authenticationBloc;
  late AuthRepository authRepository;

  setUp(() {
    authenticationBloc = MockAuthenticationBloc();
    authRepository = MockAuthRepository();
  });

  testWidgets(
    'renders SignInPage when unauthenticated',
    (tester) async {
      whenListen(
        authenticationBloc,
        Stream<AuthenticationState>.fromIterable([
          const .unauthenticated(),
        ]),
        initialState: const AuthenticationState.unauthenticated(),
      );

      await tester.pumpApp(
        RepositoryProvider.value(
          value: authRepository,
          child: BlocProvider.value(
            value: authenticationBloc,
            child: const AuthenticationPage(),
          ),
        ),
      );

      expect(find.byType(SignInPage), findsOneWidget);
    },
  );

  testWidgets(
    'renders HomePage when authenticated',
    (tester) async {
      final authUser = AuthUser(id: '123');
      whenListen(
        authenticationBloc,
        Stream<AuthenticationState>.fromIterable([
          .authenticated(user: authUser),
        ]),
        initialState: AuthenticationState.authenticated(user: authUser),
      );

      await tester.pumpApp(
        RepositoryProvider.value(
          value: authRepository,
          child: BlocProvider.value(
            value: authenticationBloc,
            child: const AuthenticationPage(),
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
