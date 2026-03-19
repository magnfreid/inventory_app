import 'package:user_remote/user_remote.dart';
import 'package:user_repository/user_repository.dart';

/// Repository for fetching and watching [User]s from a [UserRemote].
class UserRepository {
  /// Creates a [UserRepository] with the given [remote] data source.
  UserRepository({required UserRemote remote}) : _remote = remote;

  final UserRemote _remote;

  /// Watches a single user by [userId].
  ///
  /// Returns a stream of [User] or `null` if the user does not exist.
  Stream<User?> watchUser(String userId) => _remote
      .watchUser(userId)
      .map((dto) => dto == null ? null : User.fromDto(dto));

  //TODO(magnfreid): Add sharedReplay!

  /// Watches all users belonging to a specific [organizationId].
  ///
  /// Returns a stream of [User] domain models.
  Stream<List<User>> watchUsers(String organizationId) {
    return _remote
        .watchUsers(organizationId)
        .map((dtos) => dtos.map(User.fromDto).toList());
  }
}
