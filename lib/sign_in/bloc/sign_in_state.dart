import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

enum SignInPageStatus { idle, loading }

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(SignInPageStatus.idle) SignInPageStatus status,
    Exception? error,
  }) = _SignInState;

  const SignInState._();

  bool get isLoading => status == .loading;
}
