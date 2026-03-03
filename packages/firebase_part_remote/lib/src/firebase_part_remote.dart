import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_part_remote/src/constants/constants.dart';
import 'package:part_remote/part_remote.dart';

class FirebasePartRemote implements PartRemote {
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
  Future<PartDto> addPart(PartCreateDto createModel) async {
    final docRef = _collection.doc();
    final dto = PartDto.fromCreateModel(docRef.id, createModel);
    await docRef.set(dto);
    return dto;
  }

  @override
  Future<void> editPart(PartDto updatedPart) async {
    final docRef = _collection.doc(updatedPart.id);
    return docRef.update({
      'name': updatedPart.name,
      'detailNumber': updatedPart.detailNumber,
      'price': updatedPart.price,
      'isRecycled': updatedPart.isRecycled,
      'categoryTagId': updatedPart.categoryTagId,
      'brandTagId': updatedPart.brandTagId,
      'generalTagIds': updatedPart.generalTagIds,
      'description': updatedPart.description,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
