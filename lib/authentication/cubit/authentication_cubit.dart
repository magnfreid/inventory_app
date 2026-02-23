import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthenticationState.loading()) {
    _userSubscription = _authRepository.currentUser.listen(
      _onUserChanged,
    );
  }

  final AuthRepository _authRepository;
  late final StreamSubscription<AuthUser?> _userSubscription;

  void _onUserChanged(AuthUser? user) {
    if (user == null) {
      emit(const AuthenticationState.unauthenticated());
    } else {
      emit(AuthenticationState.authenticated(user: user));
    }
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }
}
