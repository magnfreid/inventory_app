import 'package:core_remote/core_remote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/stock_repository.dart';

class MockStockRemote extends Mock implements StockRemote {}

void main() {
  late MockStockRemote mockRemote;
  late StockRepository repository;
  late StockDto stockDto;
  late TransactionDto transactionDto;
  late DateTime now;

  setUpAll(() {
    registerFallbackValue(
      StockDto(partId: 'fallback', storageId: 'fallback', quantity: 0),
    );
    registerFallbackValue(
      TransactionDto(
        partId: '',
        storageId: '',
        amount: 0,
        id: '',
        userId: '',
        type: TransactionType.adjustment,
        note: '',
        timestamp: DateTime.now(),
      ),
    );
  });

  setUp(() {
    now = DateTime.now();
    mockRemote = MockStockRemote();
    repository = StockRepository(remote: mockRemote);
    stockDto = StockDto(partId: 'p1', storageId: 's1', quantity: 10);
    transactionDto = TransactionDto(
      id: '123',
      partId: 'p1',
      storageId: 's1',
      userId: '456',
      amount: 1,
      type: TransactionType.restock,
      note: 'note',
      timestamp: now,
    );
  });

  group('StockRepository', () {
    test('watchStock maps DTOs to domain models', () async {
      when(
        () => mockRemote.watchStock(),
      ).thenAnswer((_) => Stream.value([stockDto]));

      final stocks = await repository.watchStock().first;

      expect(stocks.first.partId, stockDto.partId);
      expect(stocks.first.storageId, stockDto.storageId);
      expect(stocks.first.quantity, stockDto.quantity);
    });

    test('watchTransactions maps DTOs to domain models', () async {
      when(
        () => mockRemote.watchTransactions(),
      ).thenAnswer((_) => Stream.value([transactionDto]));

      final transactions = await repository.watchTransactions().first;

      expect(transactions.first.partId, transactionDto.partId);
      expect(transactions.first.storageId, transactionDto.storageId);
      expect(transactions.first.amount, transactionDto.amount);
    });

    test('fetchTransactionsForMonth maps DTOs to domain models', () async {
      when(
        () => mockRemote.fetchTransactionsForMonth(any()),
      ).thenAnswer((_) async => [transactionDto]);

      final transactions = await repository.fetchTransactionsForMonth(
        DateTime(now.year, now.month),
      );

      expect(transactions.first.partId, transactionDto.partId);
      verify(() => mockRemote.fetchTransactionsForMonth(any())).called(1);
    });

    test('useStock calls remote with correct parameters', () async {
      when(() => mockRemote.applyStockChange(any())).thenAnswer((_) async {});
      await repository.useStock(
        partId: transactionDto.partId,
        storageId: transactionDto.storageId,
        userId: transactionDto.userId,
        userDisplayName: 'Alice',
        partName: 'Part',
        detailNumber: 'D1',
        storageName: 'Shelf',
        unitPriceSnapshot: 9.99,
        isRecycledPart: false,
        note: transactionDto.note ?? '',
      );

      verify(() => mockRemote.applyStockChange(any())).called(1);
    });

    test('restock calls remote with correct parameters', () async {
      when(() => mockRemote.applyStockChange(any())).thenAnswer((_) async {});

      await repository.restockStock(
        partId: transactionDto.partId,
        storageId: transactionDto.storageId,
        userId: transactionDto.userId,
        userDisplayName: 'Alice',
        partName: 'Part',
        detailNumber: 'D1',
        storageName: 'Shelf',
        unitPriceSnapshot: 9.99,
        isRecycledPart: false,
        amount: transactionDto.amount,
      );

      verify(() => mockRemote.applyStockChange(any())).called(1);
    });

    test('useStock rethrows RemoteException from remote', () async {
      when(
        () => mockRemote.applyStockChange(any()),
      ).thenThrow(const InvalidArgumentRemoteException());

      expect(
        () => repository.useStock(
          partId: 'p1',
          storageId: 's1',
          userId: 'u1',
          userDisplayName: 'A',
          partName: 'P',
          detailNumber: 'D',
          storageName: 'S',
          unitPriceSnapshot: 1,
          isRecycledPart: false,
          note: 'note',
        ),
        throwsA(isA<InvalidArgumentRemoteException>()),
      );
    });

    test(
      'useStock wraps unknown exception into UnknownRemoteException',
      () async {
        when(
          () => mockRemote.applyStockChange(any()),
        ).thenThrow(Exception('oops'));

        expect(
          () => repository.useStock(
            partId: 'p1',
            storageId: 's1',
            userId: 'u1',
            userDisplayName: 'A',
            partName: 'P',
            detailNumber: 'D',
            storageName: 'S',
            unitPriceSnapshot: 1,
            isRecycledPart: false,
            note: 'note',
          ),
          throwsA(isA<UnknownRemoteException>()),
        );
      },
    );
  });
}
