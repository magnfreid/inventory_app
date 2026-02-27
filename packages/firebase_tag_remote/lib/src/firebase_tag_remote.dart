import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tag_remote/src/constants/constants.dart';
import 'package:tag_remote/tag_remote.dart';

class FirebaseTagRemote implements TagRemote {
  FirebaseTagRemote({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _mainTagscollection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(mainTagsCollection)
        .withConverter<TagDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return TagDto.fromJson({
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
  late final CollectionReference<TagDto> _mainTagscollection;

  @override
  Future<TagDto> addMainTag(TagCreateDto tag) async {
    final docRef = _mainTagscollection.doc();
    final dto = TagDto.fromCreateModel(createModel: tag, id: docRef.id);
    return dto;
  }

  @override
  Future<void> deleteMainTag(String id) async {
    await _mainTagscollection.doc(id).delete();
  }

  @override
  Stream<List<TagDto>> watchMainTags() {
    return _mainTagscollection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
