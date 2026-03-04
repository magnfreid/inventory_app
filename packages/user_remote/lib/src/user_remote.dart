import 'package:user_remote/user_remote.dart';

/// Interface defining the remote data source for [UserDto]s.
abstract interface class UserRemote {
  /// Watches a single user by [userId].
  ///
  /// Returns a stream of [UserDto] or `null` if the user does not exist.
  Stream<UserDto?> watchUser(String userId);

  /// Watches all users for a given [organizationId].
  ///
  /// Returns a stream of [UserDto]s.
  Stream<List<UserDto>> watchUsers(String organizationId);
}
