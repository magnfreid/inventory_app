import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tag_remote/src/constants/constants.dart';
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
          toFirestore: (dto, _) => dto.toJson(),
        );
  }
  final FirebaseFirestore _firestore;
  late final CollectionReference<TagDto> _collection;

  @override
  Future<TagDto> addTag(TagDto tag) async {
    final docRef = _collection.doc();
    final dtoWithId = tag.copyWith(id: docRef.id);
    await docRef.set(dtoWithId);
    return dtoWithId;
  }

  @override
  Future<void> deleteTag(String id) async {
    await _collection.doc(id).delete();
  }

  @override
  Stream<List<TagDto>> watchTags() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<void> editTag(TagDto tag) async {
    final docRef = _collection.doc(tag.id);
    await docRef.update(tag.toJson());
  }
}
