import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_stock_remote/firebase_stock_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_remote/stock_remote.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late StockRemote remote;
  late StockDto stock;
  late TransactionDto useTransaction;
  late TransactionDto restockTransaction;
  late TransactionDto emptyTransaction;
  late DateTime now;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    remote = FirebaseStockRemote(organizationId: 'org1', firestore: firestore);
    now = DateTime.now();
    stock = StockDto(partId: '123', storageId: '456', quantity: 5);
    useTransaction = TransactionDto(
      id: '111',
      partId: '123',
      storageId: '456',
      userId: '789',
      amount: -1,
      type: .use,
      note: 'note',
      timestamp: now,
    );
    restockTransaction = TransactionDto(
      id: '222',
      partId: '123',
      storageId: '456',
      userId: '789',
      amount: 10,
      type: .restock,
      note: 'note',
      timestamp: now,
    );

    emptyTransaction = TransactionDto(
      id: '333',
      partId: '123',
      storageId: '456',
      userId: '789',
      amount: 0,
      type: .use,
      note: null,
      timestamp: now,
    );
  });
  group('FirebaseStockRemoteDataSource', () {
    test('watchStock emits list of StockDto with correct data', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('abc')
          .set(stock.toJson());

      await expectLater(
        remote.watchStock(),
        emits(
          isA<List<StockDto>>()
              .having(
                (list) => list.first.partId,
                'part id',
                stock.partId,
              )
              .having(
                (list) => list.first.storageId,
                'storage id',
                stock.storageId,
              )
              .having(
                (list) => list.first.quantity,
                'quantity',
                stock.quantity,
              ),
        ),
      );
    });

    test(
      'watchTransactions emits list of TransactionDto with correct data',
      () async {
        await firestore
            .collection('organizations')
            .doc('org1')
            .collection('transactions')
            .doc(restockTransaction.id)
            .set(restockTransaction.toJson());

        await expectLater(
          remote.watchTransactions(),
          emits(
            isA<List<TransactionDto>>()
                .having(
                  (list) => list.first.id,
                  'id',
                  restockTransaction.id,
                )
                .having(
                  (list) => list.first.partId,
                  'part id',
                  restockTransaction.partId,
                )
                .having(
                  (list) => list.first.storageId,
                  'storage id',
                  restockTransaction.storageId,
                )
                .having(
                  (list) => list.first.userId,
                  'user id',
                  restockTransaction.userId,
                )
                .having(
                  (list) => list.first.amount,
                  'quantity',
                  restockTransaction.amount,
                )
                .having(
                  (list) => list.first.type,
                  'type',
                  restockTransaction.type,
                )
                .having(
                  (list) => list.first.note,
                  'note',
                  restockTransaction.note,
                )
                .having(
                  (list) => list.first.timestamp,
                  'timestamp',
                  restockTransaction.timestamp,
                ),
          ),
        );
      },
    );

    test(
      'applyStockChange creates a new stock document if none exists',
      () async {
        await remote.applyStockChange(restockTransaction);

        final snapshot = await firestore
            .collection('organizations')
            .doc('org1')
            .collection('stock')
            .doc('123_456')
            .get();

        expect(snapshot.exists, true);
        expect(snapshot.data()?['quantity'], restockTransaction.amount);
      },
    );

    test('applyStockChange increments existing quantity', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .set({
            'partId': '123',
            'storageId': '456',
            'quantity': 5,
          });

      await remote.applyStockChange(restockTransaction);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .get();

      expect(snapshot.data()?['quantity'], 15);
    });

    test('applyStockChange throws if insufficient stock', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .set({
            'partId': '123',
            'storageId': '456',
            'quantity': 0,
          });
      await expectLater(
        remote.applyStockChange(useTransaction),
        throwsException,
      );
    });

    test('applyStockChange decreases quantity correctly', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .set({
            'partId': '123',
            'storageId': '456',
            'quantity': 10,
          });

      await remote.applyStockChange(useTransaction);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .get();

      expect(snapshot.data()?['quantity'], 9);
    });
    test('applyStockChange throws if amount is zero', () async {
      expect(
        () => remote.applyStockChange(emptyTransaction),
        throwsException,
      );
    });
  });
}
