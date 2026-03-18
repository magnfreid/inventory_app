import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_remote/firebase_storage_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:storage_remote/storage_remote.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late StorageRemote remote;
  late StorageDto storage;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    remote = FirebaseStorageRemote(
      organizationId: 'org1',
      firestore: firestore,
    );
    storage = StorageDto(id: '123', name: 'name');
  });

  group('FirebaseStorageRemoteDataSoure', () {
    test(
      'watchStorages emits a list of StorageDto with correct data',
      () async {
        await firestore
            .collection('organizations')
            .doc('org1')
            .collection('storages')
            .doc('123')
            .set(storage.toJson());
        await expectLater(
          remote.watchStorages(),
          emits(
            isA<List<StorageDto>>()
                .having(
                  (list) => list.first.id,
                  'id',
                  '123',
                )
                .having((list) => list.first.name, 'name', 'name'),
          ),
        );
      },
    );

    test(
      'addStorage generates id, writes to firestore and returns dto with id',
      () async {
        final input = StorageDto(id: '123', name: 'New Storage');

        final result = await remote.addStorage(input);

        expect(result.id, isNotNull);

        final snapshot = await firestore
            .collection('organizations')
            .doc('org1')
            .collection('storages')
            .doc(result.id)
            .get();

        expect(snapshot.exists, true);
        expect(snapshot.data()!.containsKey('id'), false);
        expect(snapshot.data()!['name'], 'New Storage');
      },
    );
  });
}
