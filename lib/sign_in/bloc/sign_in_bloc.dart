import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:inventory_app/sign_in/bloc/sign_in_state.dart';

part 'sign_in_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const SignInState()) {
    on<SignInButtonPressed>(_onSignInButtonPressed, transformer: droppable());
  }

  final AuthRepository _authRepository;

  FutureOr<void> _onSignInButtonPressed(
    SignInButtonPressed event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(status: .loading, error: null));
    try {
      await _authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: .idle, error: null));
    } on Exception catch (exception) {
      emit(state.copyWith(status: .idle, error: exception));
    }
  }
}
