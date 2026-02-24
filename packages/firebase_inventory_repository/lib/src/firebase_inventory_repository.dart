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
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return InventoryItem.fromJson(data);
          },
          toFirestore: (item, _) => item.toJson(),
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

  @override
  Future<void> decreaseStock({
    required String productId,
    required String locationId,
    required int amount,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }

    final id = '${productId}_$locationId';
    final docRef = _collection.doc(id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        throw Exception('No stock exists for this product at this location');
      }
      final currentQuantity = snapshot.data()?.quantity ?? 0;
      if (currentQuantity < amount) {
        throw Exception('Insufficient stock');
      }
      transaction.update(docRef, {
        'quantity': FieldValue.increment(-amount),
      });
    });
  }

  @override
  Future<void> increaseStock({
    required String productId,
    required String locationId,
    required int amount,
  }) async {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }
    final id = '${productId}_$locationId';
    final docRef = _collection.doc(id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        transaction.set(
          docRef,
          InventoryItem(
            productId: productId,
            locationId: locationId,
            quantity: amount,
          ),
        );
        return;
      }

      transaction.update(docRef, {'quantity': FieldValue.increment(amount)});
    });
  }
}
