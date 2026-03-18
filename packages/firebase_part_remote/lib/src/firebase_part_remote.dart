import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_part_remote/src/constants/constants.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:part_remote/part_remote.dart';

///Implementation of Firebase Firestore [PartRemote].
class FirebasePartRemote implements PartRemote {
  ///Creates a [FirebasePartRemote]. Optional [FirebaseFirestore]
  ///instance for testing.
  FirebasePartRemote({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(partsCollection)
        .withConverter<PartDto>(
          fromFirestore: (snapshot, _) {
            final dto = PartDto.fromJson(snapshot.data()!);
            return dto.copyWith(id: snapshot.id);
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
    return _collection
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        )
        .handleError((e) {
          if (e is FirebaseException) {
            throw mapFirebaseException(e);
          }
        });
  }

  @override
  Future<PartDto> addPart(PartDto dto) async {
    final docRef = _collection.doc();
    final dtoWithId = dto.copyWith(id: docRef.id);
    try {
      await docRef.set(dtoWithId);
      return dtoWithId;
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<PartDto> editPart(PartDto updatedPart) async {
    final docRef = _collection.doc(updatedPart.id);
    try {
      await docRef.set(updatedPart, SetOptions(merge: true));
      return updatedPart;
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> deletePart(String partId) async {
    try {
      await _collection.doc(partId).delete();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}
