import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:inventory_app/home/cubit/user_state.dart';
import 'package:user_repository/user_repository.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({
    required UserRepository userRepository,
    required String currentUserId,
  }) : _userRepository = userRepository,
       super(const .loading()) {
    _userStreamSubscription = _userRepository.watchUser(currentUserId).listen(
      (
        user,
      ) {
        if (user == null) {
          emit(.error(error: Exception('User not found')));
        } else {
          emit(.loaded(currentUser: user));
        }
      },
      onError: (error, _) => emit(.error(error: error as Exception)),
    );
  }

  final UserRepository _userRepository;
  late final StreamSubscription<User?> _userStreamSubscription;

  @override
  Future<void> close() async {
    await _userStreamSubscription.cancel();
    return super.close();
  }
}
