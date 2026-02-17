import 'package:auth_repository/auth_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';

import 'package:mocktail/mocktail.dart';
import '../../helpers/mocks.dart';

void main() {
  late SignInBloc bloc;
  late AuthRepository authRepository;
  late Exception error;

  setUp(() {
    authRepository = MockAuthRepository();
    bloc = SignInBloc(authRepository: authRepository);
    error = Exception('Test error');
  });

  test('initial state is idle with no error', () {
    expect(bloc.state, const SignInState());
  });

  blocTest<SignInBloc, SignInState>(
    'emits [loading, idle] when sign in succeeds',
    build: () {
      when(
        () => authRepository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Future.value());
      return bloc;
    },
    act: (bloc) => bloc.add(
      SignInButtonPressed(
        email: 'test@test.com',
        password: 'password',
      ),
    ),
    expect: () => [
      const SignInState(status: .loading),
      const SignInState(),
    ],
    verify: (_) {
      verify(
        () => authRepository.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'password',
        ),
      ).called(1);
    },
  );

  blocTest<SignInBloc, SignInState>(
    'emits [loading, idle with error] when sign in fails',
    build: () {
      when(
        () => authRepository.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(error);
      return bloc;
    },
    act: (bloc) => bloc.add(
      SignInButtonPressed(
        email: 'test@test.com',
        password: 'password',
      ),
    ),
    expect: () => [
      const SignInState(status: .loading),
      SignInState(
        error: error,
      ),
    ],
    verify: (_) {
      verify(
        () => authRepository.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'password',
        ),
      ).called(1);
    },
  );
}
