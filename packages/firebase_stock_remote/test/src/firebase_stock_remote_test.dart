import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_stock_remote/firebase_stock_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stock_remote/stock_remote.dart';

void main() {
  late FakeFirebaseFirestore firestore;
  late StockRemote remote;
  late StockDto stock;

  setUp(() {
    firestore = FakeFirebaseFirestore();
    remote = FirebaseStockRemote(organizationId: 'org1', firestore: firestore);
    stock = StockDto(partId: '123', storageId: '456', quantity: 5);
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
                '123',
              )
              .having((list) => list.first.storageId, 'storage id', '456')
              .having((list) => list.first.quantity, 'quantity', 5),
        ),
      );
    });
    test('increaseStock creates new document if none exists', () async {
      await remote.increaseStock('123', '456', 5);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .get();

      expect(snapshot.exists, true);
      expect(snapshot.data()?['quantity'], 5);
    });

    test('increaseStock increments existing quantity', () async {
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

      await remote.increaseStock('123', '456', 3);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .get();

      expect(snapshot.data()?['quantity'], 8);
    });

    test('increaseStock throws if amount is zero or negative', () async {
      expect(
        () => remote.increaseStock('123', '456', 0),
        throwsException,
      );
    });

    test('decreaseStock throws if stock does not exist', () async {
      expect(
        () => remote.decreaseStock('123', '456', 1),
        throwsException,
      );
    });

    test('decreaseStock throws if insufficient stock', () async {
      await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .set({
            'partId': '123',
            'storageId': '456',
            'quantity': 2,
          });

      expect(
        () => remote.decreaseStock('123', '456', 5),
        throwsException,
      );
    });

    test('decreaseStock decreases quantity correctly', () async {
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

      await remote.decreaseStock('123', '456', 4);

      final snapshot = await firestore
          .collection('organizations')
          .doc('org1')
          .collection('stock')
          .doc('123_456')
          .get();

      expect(snapshot.data()?['quantity'], 6);
    });
    test('decreaseStock throws if amount is zero or negative', () async {
      expect(
        () => remote.decreaseStock('123', '456', 0),
        throwsException,
      );
    });
  });
}
