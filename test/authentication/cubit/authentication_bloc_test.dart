import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/authentication/cubit/authentication_cubit.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';
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
      final cubit = AuthenticationCubit(authRepository: authRepository);
      expect(cubit.state, const AuthenticationState.loading());
      await cubit.close();
    });

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits unauthenticated when user stream emits null',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => Stream.value(null));
        return AuthenticationCubit(authRepository: authRepository);
      },
      expect: () => [const AuthenticationState.unauthenticated()],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits authenticated when user stream emits a user',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => Stream.value(user));
        return AuthenticationCubit(authRepository: authRepository);
      },
      expect: () => [
        AuthenticationState.authenticated(user: user),
      ],
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'calls signOut on AuthRepository when SignOutButtonPressed is added',
      build: () {
        when(
          () => authRepository.currentUser,
        ).thenAnswer((_) => const Stream.empty());
        when(() => authRepository.signOut()).thenAnswer((_) async {});
        return AuthenticationCubit(authRepository: authRepository);
      },
      act: (bloc) => bloc.signOut(),
      verify: (_) {
        verify(() => authRepository.signOut()).called(1);
      },
    );
  });
}
