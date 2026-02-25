import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_remote_data_source/stock_remote_data_source.dart';

class FirebaseStockRemoteDataSource implements StockRemoteDataSource {
  FirebaseStockRemoteDataSource({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection('organizations')
        .doc(organizationId)
        .collection('stock')
        .withConverter<StockDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            return StockDto.fromJson(data);
          },
          toFirestore: (dto, _) => dto.toJson(),
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<StockDto> _collection;

  @override
  Stream<List<StockDto>> watchStock() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<void> increaseStock(
    String partId,
    String storageId,
    int amount,
  ) async {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }
    final id = '${partId}_$storageId';
    final docRef = _collection.doc(id);
    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      if (!snapshot.exists) {
        transaction.set(
          docRef,
          StockDto(
            partId: partId,
            storageId: storageId,
            quantity: amount,
          ),
        );
        return;
      }
      transaction.update(
        docRef,
        {'quantity': FieldValue.increment(amount)},
      );
    });
  }

  @override
  Future<void> decreaseStock(
    String partId,
    String storageId,
    int amount,
  ) async {
    if (amount <= 0) {
      throw ArgumentError('Amount must be greater than 0');
    }

    final id = '${partId}_$storageId';
    final docRef = _collection.doc(id);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        throw Exception(
          'No stock exists for this part at this storage',
        );
      }
      final currentQuantity = snapshot.data()?.quantity ?? 0;
      if (currentQuantity < amount) {
        throw Exception('Insufficient stock');
      }
      transaction.update(docRef, {'quantity': FieldValue.increment(-amount)});
    });
  }
}
