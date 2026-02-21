import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_repository/inventory_repository.dart';

class FirebaseInventoryRepository implements InventoryRepository {
  FirebaseInventoryRepository({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('inventory')
        .withConverter<InventoryItem>(
          fromFirestore: (snapshot, _) =>
              InventoryItem.fromJson(snapshot.data()!..['id'] = snapshot.id),
          toFirestore: (item, _) {
            final json = item.toJson()..remove('id');
            return json;
          },
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<InventoryItem> _collection;

  @override
  Stream<List<InventoryItem>> watchInventoryItems() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
