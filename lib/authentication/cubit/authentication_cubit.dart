import 'dart:async';

import 'package:authentication_service/authentication_service.dart';
import 'package:bloc/bloc.dart';
import 'package:inventory_app/authentication/cubit/authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({required AuthenticationService authService})
    : _authService = authService,
      super(const AuthenticationState.loading()) {
    _userSubscription = _authService.currentUser.listen(
      _onUserChanged,
    );
  }

  final AuthenticationService _authService;
  late final StreamSubscription<AuthenticatedUser?> _userSubscription;

  void _onUserChanged(AuthenticatedUser? user) {
    if (user == null) {
      emit(const AuthenticationState.unauthenticated());
    } else {
      emit(AuthenticationState.authenticated(user: user));
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    return super.close();
  }
}
