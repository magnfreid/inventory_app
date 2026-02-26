import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_user_remote/src/constants/constants.dart';
import 'package:user_remote/user_remote.dart';

class FirebaseUserRemote implements UserRemote {
  FirebaseUserRemote({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection(usersCollection)
        .withConverter<UserDto>(
          fromFirestore: (snapshot, _) {
            final json = snapshot.data()!;
            return UserDto.fromJson({
              ...json,
              'id': snapshot.id,
            });
          },
          toFirestore: (dto, _) {
            final json = dto.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<UserDto> _collection;

  @override
  Stream<UserDto?> watchUser(String userId) {
    return _collection.doc(userId).snapshots().map((doc) => doc.data());
  }

  @override
  Stream<List<UserDto>> watchUsers(String organizationId) {
    return _collection
        .where('organizationId', isEqualTo: organizationId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
