import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authentication/bloc/authentication_bloc.dart';
import 'package:inventory_app/authentication/bloc/authentication_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late AuthUser user;

  setUp(() {
    authRepository = MockAuthRepository();
    user = AuthUser(id: '123');
  });

  group('AuthenticationBloc', () {
    test('initial state is loading', () async {
      when(
        () => authRepository.currentUser,
      ).thenAnswer((_) => const Stream.empty());
      final bloc = AuthenticationBloc(authRepository: authRepository);
      expect(bloc.state, const AuthenticationState.loading());
      await bloc.close();
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits unauthenticated when user stream emits null',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => Stream.value(null));
        return AuthenticationBloc(authRepository: authRepository);
      },
      expect: () => [const AuthenticationState.unauthenticated()],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emits authenticated when user stream emits a user',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => Stream.value(user));
        return AuthenticationBloc(authRepository: authRepository);
      },
      expect: () => [
        AuthenticationState.authenticated(user: user),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'calls signOut on AuthRepository when SignOutButtonPressed is added',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => const Stream.empty());
        when(() => authRepository.signOut()).thenAnswer((_) async {});
        return AuthenticationBloc(authRepository: authRepository);
      },
      act: (bloc) => bloc.add(SignOutButtonPressed()),
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );
  });
}
