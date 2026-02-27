import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage_remote/src/constants/constants.dart';
import 'package:storage_remote/storage_remote.dart';

class FirebaseStorageRemote implements StorageRemote {
  FirebaseStorageRemote({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(storagesCollection)
        .withConverter<StorageDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return StorageDto.fromJson({
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
  late final CollectionReference<StorageDto> _collection;

  @override
  Stream<List<StorageDto>> watchStorages() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<StorageDto> addStorage(StorageDto dto) async {
    final docRef = _collection.doc();
    final dtoWithId = StorageDto(
      id: docRef.id,
      name: dto.name,
      description: dto.description,
    );
    await docRef.set(dtoWithId);
    return dtoWithId;
  }
}
