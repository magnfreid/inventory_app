import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:part_remote_data_source/part_remote_data_source.dart';

class FirebasePartRemoteDataSource implements PartRemoteDataSource {
  FirebasePartRemoteDataSource({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('parts')
        .withConverter<PartDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return PartDto.fromJson({
              ...data,
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
  late final CollectionReference<PartDto> _collection;

  @override
  Stream<List<PartDto>> watchParts() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<PartDto> addPart(PartDto dto) async {
    final docRef = _collection.doc(dto.id);
    await docRef.set(dto);
    return dto;
  }
}
