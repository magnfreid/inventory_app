import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<User?> currentUser(String userId) =>
      _firestore.collection('users').doc().snapshots().map((doc) {
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
