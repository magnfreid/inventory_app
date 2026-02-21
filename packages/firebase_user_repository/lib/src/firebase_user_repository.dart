import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/user_repository.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('users')
        .withConverter<User>(
          fromFirestore: (snapshot, _) {
            final json = snapshot.data()!;
            return User.fromJson({
              ...json,
              'id': snapshot.id,
            });
          },
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<User> _collection;

  @override
  Stream<User?> watchUser(String userId) {
    return _collection.doc(userId).snapshots().map((doc) => doc.data());
  }

  @override
  Stream<List<User>> watchUsers(String organizationId) {
    return _collection
        .where('organizationId', isEqualTo: organizationId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
