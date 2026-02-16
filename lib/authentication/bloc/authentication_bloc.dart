import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inventory_app/authentication/bloc/authentication_state.dart';

part 'authentication_event.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const .loading()) {
    on<_OnUserChanged>(_onUserChanged);

    _userSubscription = _authRepository.currentUser.listen(
      (user) => add(_OnUserChanged(newUser: user)),
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<AuthUser?> _userSubscription;

  FutureOr<void> _onUserChanged(
    _OnUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    final user = event.newUser;
    user == null
        ? emit(const .unauthenticated())
        : emit(.authenticated(user: user));
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }
}
