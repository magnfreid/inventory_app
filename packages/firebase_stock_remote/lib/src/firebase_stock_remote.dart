import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_shared/firebase_shared.dart';
import 'package:firebase_stock_remote/src/constants/constants.dart';
import 'package:stock_remote/stock_remote.dart';

///Implementation of a Firebase Firestore [StockRemote].
class FirebaseStockRemote implements StockRemote {
  ///Creates a [FirebaseStockRemote]. Optional [FirebaseFirestore], used for
  /// testing.
  FirebaseStockRemote({
    required String organizationId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(stockCollection)
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
    return _collection
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        )
        //
        // ignore: inference_failure_on_untyped_parameter
        .handleError((e) {
          if (e is FirebaseException) {
            throw mapFirebaseException(e);
          }
        });
  }

  @override
  Future<void> increaseStock(
    String partId,
    String storageId,
    int amount,
  ) async {
    final id = '${partId}_$storageId';
    final docRef = _collection.doc(id);
    try {
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
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }

  @override
  Future<void> decreaseStock(
    String partId,
    String storageId,
    int amount,
  ) async {
    final id = '${partId}_$storageId';
    try {
      final docRef = _collection.doc(id);
      await _firestore.runTransaction((transaction) async {
        final snapshot = await transaction.get(docRef);
        final currentQuantity = snapshot.data()?.quantity ?? 0;
        if (currentQuantity < amount) return;
        transaction.update(docRef, {'quantity': FieldValue.increment(-amount)});
      });
    } on FirebaseException catch (e) {
      throw mapFirebaseException(e);
    }
  }
}
