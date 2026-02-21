import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.loading() = _Loading;
  const factory UserState.error({required Exception error}) = _Error;
  const factory UserState.loaded({required User currentUser}) = _Loaded;
}
