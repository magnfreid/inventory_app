import 'package:user_repository/user_repository.dart';

abstract interface class UserRepository {
  Stream<User?> watchUser(String userId);
  Stream<List<User>?> watchUsers(String organizationId);
}
