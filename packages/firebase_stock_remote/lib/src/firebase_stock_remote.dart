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
    _stockCollection = _firestore
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

    _transactionsCollection = _firestore
        .collection(organizationsCollection)
        .doc(organizationId)
        .collection(transactionsCollection)
        .withConverter<TransactionDto>(
          fromFirestore: (snapshot, _) {
            final data = snapshot.data()!;
            final dto = TransactionDto.fromJson(data).copyWith(id: snapshot.id);
            return dto;
          },
          toFirestore: (dto, _) => dto.toJson()..remove('id'),
        );
  }

  final FirebaseFirestore _firestore;
  late final CollectionReference<StockDto> _stockCollection;
  late final CollectionReference<TransactionDto> _transactionsCollection;

  @override
  Stream<List<StockDto>> watchStock() {
    return _stockCollection
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
  Stream<List<TransactionDto>> watchTransactions() {
    return _transactionsCollection
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
  Future<void> applyStockChange(TransactionDto transaction) async {
    final stockDoc = _stockCollection.doc(
      '${transaction.partId}_${transaction.storageId}',
    );

    final transactionDoc = _transactionsCollection.doc();

    await _firestore.runTransaction((txn) async {
      final snapshot = await txn.get(stockDoc);
      final currentDto = snapshot.exists
          ? snapshot.data()!
          : StockDto(
              partId: transaction.partId,
              storageId: transaction.storageId,
              quantity: 0,
            );

      final newStock = currentDto.quantity + transaction.amount;
      if (newStock < 0) throw invalidArgument;

      final updatedDto = currentDto.copyWith(quantity: newStock);

      txn
        ..set(stockDoc, updatedDto)
        ..set(transactionDoc, transaction);
    });
  }
}
