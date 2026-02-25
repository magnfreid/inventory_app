import 'package:user_remote_data_source/user_remote_data_source.dart';
import 'package:user_repository/user_repository.dart';

class UserRepository {
  UserRepository({required UserRemoteDataSource remote}) : _remote = remote;
  final UserRemoteDataSource _remote;

  Stream<User?> watchUser(String userId) => _remote
      .watchUser(userId)
      .map((dto) => dto == null ? null : User.fromDto(dto));

  Stream<List<User>> watchUsers(String organizationId) {
    return _remote
        .watchUsers(organizationId)
        .map((dtos) => dtos.map(User.fromDto).toList());
  }
}
