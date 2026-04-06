import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_part_remote/firebase_part_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:part_remote/part_remote.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late FirebasePartRemote fakeRemote;
  late PartDto fakePart;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    fakeRemote = FirebasePartRemote(
      organizationId: 'org1',
      firestore: fakeFirestore,
    );
    fakePart = const PartDto(
      id: '123',
      name: '',
      detailNumber: '',
      isRecycled: true,
      price: 10,
      categoryTagId: '',
      description: '',
      brandTagId: '',
      generalTagIds: [],
      imgPath: 'imgPath',
      thumbnailPath: null,
    );
  });

  group('FirebasePartRemote', () {
    test('addPart generates id and writes dto with id', () async {
      final result = await fakeRemote.addPart(fakePart);

      expect(result.id, isNotNull);

      final snapshot = await fakeFirestore
          .collection('organizations')
          .doc('org1')
          .collection('parts')
          .doc(result.id)
          .get();

      expect(snapshot.exists, true);
    });

    test('watchParts emits list of PartDto with id from snapshot', () async {
      await fakeFirestore
          .collection('organizations')
          .doc('org1')
          .collection('parts')
          .doc('abc')
          .set(fakePart.toJson());

      await expectLater(
        fakeRemote.watchParts(),
        emits(
          isA<List<PartDto>>().having(
            (list) => list.first.id,
            'first id',
            'abc',
          ),
        ),
      );
    });
  });
}
