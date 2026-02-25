import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_remote_data_source/user_remote_data_source.dart';

class FirebaseUserRemoteDataSource implements UserRemoteDataSource {
  FirebaseUserRemoteDataSource({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('users')
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
