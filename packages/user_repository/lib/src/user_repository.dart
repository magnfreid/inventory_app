import 'package:user_repository/user_repository.dart';

abstract interface class UserRepository {
  Stream<User?> currentUser(String userId);
}
