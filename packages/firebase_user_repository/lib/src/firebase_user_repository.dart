import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Stream<User?> currentUser(String userId) =>
      firestore.collection('users').doc().snapshots().map((doc) {
        final data = doc.data();
        return data == null
            ? null
            : User(
                id: doc.id,
                name: data['name'] as String,
                email: data['email'] as String,
                role: data['role'] as UserRole,
              );
      });
}
