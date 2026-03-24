import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:tag_remote/tag_remote.dart';

///Implementation of a Firebase Firestore [TagRemote].
class FirebaseTagRemote implements TagRemote {
  ///Creates a [FirebaseTagRemote] instance. Optional [FirebaseFirestore], used
  ///for testing.
  FirebaseTagRemote({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(tagsCollection)
        .withConverter<TagDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return TagDto.fromJson({
              ...data,
              'id': snapshot.id,
            });
          },
          toFirestore: (dto, _) => dto.toJson()..remove('id'),
        );
  }
  final FirebaseFirestore _firestore;
  late final CollectionReference<TagDto> _collection;

  @override
  Future<TagDto> addTag(TagDto tag) async {
    final docRef = _collection.doc();
    final dtoWithId = tag.copyWith(id: docRef.id);
    try {
      await docRef.set(dtoWithId);
      return dtoWithId;
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> deleteTag(String id) async {
    try {
      await _collection.doc(id).delete();
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Stream<List<TagDto>> watchTags() {
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
  Future<void> editTag(TagDto dto) async {
    final docRef = _collection.doc(dto.id);
    try {
      await docRef.set(dto, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      mapFirebaseException(e);
    }
  }
}
