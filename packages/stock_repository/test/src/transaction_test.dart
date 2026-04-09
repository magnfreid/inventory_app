import 'package:flutter_test/flutter_test.dart';
import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/stock_repository.dart';

TransactionDto _baseDto({
  int amount = 5,
  TransactionType type = TransactionType.restock,
}) => TransactionDto(
  id: 'id1',
  partId: 'p1',
  storageId: 's1',
  userId: 'u1',
  userDisplayName: 'Alice',
  partName: 'Bolt',
  detailNumber: 'D1',
  storageName: 'Shelf A',
  unitPriceSnapshot: 2.5,
  isRecycledPart: true,
  amount: amount,
  type: type,
  note: 'a note',
  timestamp: DateTime(2024, 3),
);

void main() {
  group('Transaction.fromDto', () {
    test('maps all fields from dto', () {
      final dto = _baseDto();
      final tx = Transaction.fromDto(dto);

      expect(tx.id, dto.id);
      expect(tx.partId, dto.partId);
      expect(tx.storageId, dto.storageId);
      expect(tx.userId, dto.userId);
      expect(tx.userDisplayName, dto.userDisplayName);
      expect(tx.partName, dto.partName);
      expect(tx.detailNumber, dto.detailNumber);
      expect(tx.storageName, dto.storageName);
      expect(tx.unitPriceSnapshot, dto.unitPriceSnapshot);
      expect(tx.isRecycledPart, dto.isRecycledPart);
      expect(tx.amount, dto.amount);
      expect(tx.type, dto.type);
      expect(tx.note, dto.note);
      expect(tx.timestamp, dto.timestamp);
    });
  });

  group('Transaction.use', () {
    test('creates transaction with negative amount', () {
      final tx = Transaction.use(
        partId: 'p1',
        storageId: 's1',
        userId: 'u1',
        userDisplayName: 'Alice',
        partName: 'Bolt',
        detailNumber: 'D1',
        storageName: 'Shelf A',
        unitPriceSnapshot: 2.5,
        isRecycledPart: false,
        amount: 3,
        note: 'used for repair',
      );

      expect(tx.amount, -3);
      expect(tx.type, TransactionType.use);
      expect(tx.id, '');
      expect(tx.partId, 'p1');
      expect(tx.note, 'used for repair');
    });

    test('asserts amount must be > 0', () {
      expect(
        () => Transaction.use(
          partId: 'p1',
          storageId: 's1',
          userId: 'u1',
          userDisplayName: 'Alice',
          partName: 'Bolt',
          detailNumber: 'D1',
          storageName: 'Shelf A',
          unitPriceSnapshot: 2.5,
          isRecycledPart: false,
          amount: 0,
          note: '',
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('Transaction.restock', () {
    test('creates transaction with positive amount', () {
      final tx = Transaction.restock(
        partId: 'p1',
        storageId: 's1',
        userId: 'u1',
        userDisplayName: 'Alice',
        partName: 'Bolt',
        detailNumber: 'D1',
        storageName: 'Shelf A',
        unitPriceSnapshot: 2.5,
        isRecycledPart: false,
        amount: 10,
      );

      expect(tx.amount, 10);
      expect(tx.type, TransactionType.restock);
      expect(tx.id, '');
    });

    test('asserts amount must be > 0', () {
      expect(
        () => Transaction.restock(
          partId: 'p1',
          storageId: 's1',
          userId: 'u1',
          userDisplayName: 'Alice',
          partName: 'Bolt',
          detailNumber: 'D1',
          storageName: 'Shelf A',
          unitPriceSnapshot: 2.5,
          isRecycledPart: false,
          amount: 0,
        ),
        throwsA(isA<AssertionError>()),
      );
    });
  });

  group('Transaction.adjustment', () {
    test('creates transaction with positive amount', () {
      final tx = Transaction.adjustment(
        partId: 'p1',
        storageId: 's1',
        userId: 'u1',
        userDisplayName: 'Alice',
        partName: 'Bolt',
        detailNumber: 'D1',
        storageName: 'Shelf A',
        unitPriceSnapshot: 2.5,
        isRecycledPart: false,
        amount: 5,
        note: 'correction',
      );

      expect(tx.amount, 5);
      expect(tx.type, TransactionType.adjustment);
    });

    test('creates transaction with negative amount', () {
      final tx = Transaction.adjustment(
        partId: 'p1',
        storageId: 's1',
        userId: 'u1',
        userDisplayName: 'Alice',
        partName: 'Bolt',
        detailNumber: 'D1',
        storageName: 'Shelf A',
        unitPriceSnapshot: 2.5,
        isRecycledPart: false,
        amount: -2,
        note: 'correction',
      );

      expect(tx.amount, -2);
    });
  });

  group('Transaction.toDto', () {
    test('roundtrip fromDto → toDto preserves all fields', () {
      final dto = _baseDto();
      final tx = Transaction.fromDto(dto);
      final backToDto = tx.toDto();

      expect(backToDto.id, isNull);
      expect(backToDto.partId, dto.partId);
      expect(backToDto.storageId, dto.storageId);
      expect(backToDto.userId, dto.userId);
      expect(backToDto.userDisplayName, dto.userDisplayName);
      expect(backToDto.partName, dto.partName);
      expect(backToDto.detailNumber, dto.detailNumber);
      expect(backToDto.storageName, dto.storageName);
      expect(backToDto.unitPriceSnapshot, dto.unitPriceSnapshot);
      expect(backToDto.isRecycledPart, dto.isRecycledPart);
      expect(backToDto.amount, dto.amount);
      expect(backToDto.type, dto.type);
      expect(backToDto.note, dto.note);
    });
  });
}
