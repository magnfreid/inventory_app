import 'package:catalogue_repository/catalogue_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCatalogueRepository implements CatalogueRepository {
  FirebaseCatalogueRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('catalogue')
        .withConverter<CatalogueItem>(
          fromFirestore: (snapshot, _) {
            final json = snapshot.data()!;
            return CatalogueItem.fromJson({
              ...json,
              'id': snapshot.id,
            });
          },
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<CatalogueItem> _collection;

  @override
  Future<void> addCatalogueItem({required CatalogueItem item}) {
    // TODO: implement addCatalogueItem
    throw UnimplementedError();
  }

  @override
  Future<void> removeCatalogueItem({required String id}) {
    // TODO: implement removeCatalogueItem
    throw UnimplementedError();
  }

  @override
  Future<void> updateCatalogueItem({required CatalogueItem item}) {
    // TODO: implement updateCatalogueItem
    throw UnimplementedError();
  }

  @override
  Stream<List<CatalogueItem>> watchCatalogueItems() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
