import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:firebase_storage_remote/src/constants/constants.dart';
import 'package:storage_remote/storage_remote.dart';

///Implementation of a Firebase Firestore [StorageRemote].
class FirebaseStorageRemote implements StorageRemote {
  ///Creates a [FirebaseStorageRemote]. Optional [FirebaseFirestore], used for
  /// testing.
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
    return _collection
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        )
        //
        // ignore: inference_failure_on_untyped_parameter
        .handleError((e) {
          if (e is FirebaseException) {
            throw mapFirebaseException(e);
          }
        });
  }

  @override
  Future<StorageDto> addStorage(StorageDto dto) async {
    final docRef = _collection.doc();
    final dtoWithId = StorageDto(
      id: docRef.id,
      name: dto.name,
      description: dto.description,
    );
    try {
      await docRef.set(dtoWithId);
      return dtoWithId;
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<StorageDto> editStorage(StorageDto updatedStorage) async {
    final docRef = _collection.doc(updatedStorage.id);
    try {
      await docRef.set(updatedStorage, SetOptions(merge: true));
      return updatedStorage;
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}
