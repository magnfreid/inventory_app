import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_app/authenticated_app/cubit/user_cubit.dart';
import 'package:inventory_app/authenticated_app/cubit/user_state.dart';

/// Extensions on [BuildContext] for reading the current user from
/// [UserCubit].
extension UserCubitContext on BuildContext {
  /// Returns the authenticated user's ID, or `null` if not yet loaded.
  String? get currentUserId => read<UserCubit>().state.maybeWhen(
    loaded: (currentUser) => currentUser.id,
    orElse: () => null,
  );

  /// Returns the authenticated user's display name, or an empty string
  /// if not yet loaded.
  String get currentUserDisplayName => read<UserCubit>().state.maybeWhen(
    loaded: (currentUser) => currentUser.name,
    orElse: () => '',
  );
}
