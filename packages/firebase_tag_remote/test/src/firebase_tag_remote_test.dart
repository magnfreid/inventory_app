import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_tag_remote/firebase_tag_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tag_remote/tag_remote.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late TagRemote remote;
  late TagDto tag;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    remote = FirebaseTagRemote(organizationId: 'org1', firestore: firestore);
    tag = TagDto(id: null, label: 'New tag', color: 'blue', type: 'brand');
  });

  group('FirebaseTagRemote', () {
    test('watchTags emits a list of TagDto with correct values', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc()
          .set(tag.toJson());

      await expectLater(
        remote.watchTags(),
        emits(
          isA<List<TagDto>>()
              .having(
                (list) => list.first.id,
                'id',
                isNotNull,
              )
              .having((list) => list.first.label, 'label', 'New tag')
              .having((list) => list.first.color, 'color', 'blue')
              .having((list) => list.first.type, 'type', 'brand'),
        ),
      );
    });
    test('editTag updates existing tag document', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc('123')
          .set(tag.toJson());

      final updatedTag = TagDto(
        id: '123',
        label: 'Updated Name',
        color: tag.color,
        type: tag.type,
      );

      await remote.editTag(updatedTag);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc('123')
          .get();

      expect(snapshot.data()?['label'], 'Updated Name');
    });

    test('deleteTag removes document from firestore', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc('123')
          .set(tag.toJson());

      await remote.deleteTag('123');

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc('123')
          .get();

      expect(snapshot.exists, false);
    });

    test('watchTags emits updated list after delete', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('tags')
          .doc('123')
          .set(tag.toJson());

      final stream = remote.watchTags();

      await remote.deleteTag('123');

      await expectLater(
        stream,
        emits(
          isA<List<TagDto>>().having(
            (list) => list.isEmpty,
            'is empty',
            true,
          ),
        ),
      );
    });
  });
}
