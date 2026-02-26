import 'package:user_remote/user_remote.dart';
import 'package:user_repository/user_repository.dart';

class UserRepository {
  UserRepository({required UserRemote remote}) : _remote = remote;
  final UserRemote _remote;

  Stream<User?> watchUser(String userId) => _remote
      .watchUser(userId)
      .map((dto) => dto == null ? null : User.fromDto(dto));

  Stream<List<User>> watchUsers(String organizationId) {
    return _remote
        .watchUsers(organizationId)
        .map((dtos) => dtos.map(User.fromDto).toList());
  }
}
