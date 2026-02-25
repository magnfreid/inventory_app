import 'package:user_remote_data_source/user_remote_data_source.dart';

abstract interface class UserRemoteDataSource {
  Stream<UserDto?> watchUser(String userId);
  Stream<List<UserDto>> watchUsers(String organizationId);
}
