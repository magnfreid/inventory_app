import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:storage_repository/storage_repository.dart';

class FirebaseLocationRepository implements StorageRepository {
  FirebaseLocationRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('storages')
        .withConverter<Storage>(
          fromFirestore: (snapshot, _) =>
              Storage.fromJson(snapshot.data()!..['id'] = snapshot.id),
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<Storage> _collection;

  @override
  Stream<List<Storage>> watchStorages() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Storage> add({
    required StorageCreateModel storageCreateModel,
  }) async {
    final docRef = _collection.doc();
    final storage = Storage.fromCreateModel(
      id: docRef.id,
      createModel: storageCreateModel,
    );
    await docRef.set(storage);
    return storage;
  }
}
