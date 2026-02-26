import 'package:user_remote/user_remote.dart';

abstract interface class UserRemote {
  Stream<UserDto?> watchUser(String userId);
  Stream<List<UserDto>> watchUsers(String organizationId);
}
