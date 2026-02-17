import 'package:auth_repository/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_state.freezed.dart';

@freezed
sealed class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.loading() = _Loading;
  const factory AuthenticationState.unauthenticated() = _Unauthenticated;
  const factory AuthenticationState.authenticated({required AuthUser user}) =
      _Authenticated;
}
