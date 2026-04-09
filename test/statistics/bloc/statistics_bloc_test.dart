import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_app/statistics/bloc/statistics_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/stock_repository.dart';

class MockStockRepository extends Mock implements StockRepository {}

TransactionDto _makeDto({
  required String id,
  required int amount,
  bool isRecycledPart = false,
  double unitPriceSnapshot = 10.0,
  String partName = 'Part',
  DateTime? timestamp,
}) => TransactionDto(
  id: id,
  partId: 'p1',
  storageId: 's1',
  userId: 'u1',
  amount: amount,
  type: amount >= 0 ? TransactionType.restock : TransactionType.use,
  note: '',
  timestamp: timestamp ?? DateTime(2024, 3),
  isRecycledPart: isRecycledPart,
  unitPriceSnapshot: unitPriceSnapshot,
  partName: partName,
);

Transaction _makeTx({
  required int amount,
  bool isRecycledPart = false,
  double unitPriceSnapshot = 10.0,
  String partName = 'Part',
  DateTime? timestamp,
}) => Transaction.fromDto(
  _makeDto(
    id: 'tx1',
    amount: amount,
    isRecycledPart: isRecycledPart,
    unitPriceSnapshot: unitPriceSnapshot,
    partName: partName,
    timestamp: timestamp,
  ),
);

void main() {
  late MockStockRepository mockRepo;

  setUpAll(() {
    registerFallbackValue(DateTime(2024));
  });

  setUp(() {
    mockRepo = MockStockRepository();
    when(
      () => mockRepo.fetchTransactionsForMonth(any()),
    ).thenAnswer((_) async => []);
  });

  group('StatisticsBloc', () {
    blocTest<StatisticsBloc, StatisticsState>(
      'emits loaded with empty stats on initial load',
      build: () => StatisticsBloc(stockRepository: mockRepo),
      expect: () => [
        isA<StatisticsState>()
            .having((s) => s.status, 'status', StatisticsStatus.loaded)
            .having((s) => s.stats.totalIncoming, 'incoming', 0)
            .having((s) => s.stats.totalOutgoing, 'outgoing', 0),
      ],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'emits loaded with correct totals when transactions returned',
      build: () {
        when(
          () => mockRepo.fetchTransactionsForMonth(any()),
        ).thenAnswer(
          (_) async => [
            _makeTx(amount: 5),
            _makeTx(amount: -3),
          ],
        );
        return StatisticsBloc(stockRepository: mockRepo);
      },
      expect: () => [
        isA<StatisticsState>()
            .having((s) => s.status, 'status', StatisticsStatus.loaded)
            .having((s) => s.stats.totalIncoming, 'incoming', 5)
            .having((s) => s.stats.totalOutgoing, 'outgoing', 3),
      ],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'emits error status when fetch throws',
      build: () {
        when(
          () => mockRepo.fetchTransactionsForMonth(any()),
        ).thenThrow(Exception('network error'));
        return StatisticsBloc(stockRepository: mockRepo);
      },
      expect: () => [
        isA<StatisticsState>().having(
          (s) => s.status,
          'status',
          StatisticsStatus.error,
        ),
      ],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'StatisticsMonthChanged emits loading then loaded for new month',
      build: () => StatisticsBloc(stockRepository: mockRepo),
      seed: () => StatisticsState(
        selectedMonth: DateTime(2024, 3),
        status: StatisticsStatus.loaded,
        stats: const MonthlyStats.empty(),
      ),
      act: (bloc) => bloc.add(StatisticsMonthChanged(DateTime(2024, 2))),
      // skip 1: the constructor's StatisticsLoadRequested emits a loaded state
      // before the act event is processed
      skip: 1,
      expect: () => [
        isA<StatisticsState>()
            .having(
              (s) => s.selectedMonth.month,
              'month',
              2,
            )
            .having((s) => s.status, 'status', StatisticsStatus.loading),
        isA<StatisticsState>().having(
          (s) => s.status,
          'status',
          StatisticsStatus.loaded,
        ),
      ],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'StatisticsMonthStepRequested with delta -1 moves to previous month',
      build: () => StatisticsBloc(stockRepository: mockRepo),
      seed: () => StatisticsState(
        selectedMonth: DateTime(2024, 3),
        status: StatisticsStatus.loaded,
        stats: const MonthlyStats.empty(),
      ),
      act: (bloc) => bloc.add(const StatisticsMonthStepRequested(-1)),
      // skip 1: constructor's StatisticsLoadRequested emits first
      skip: 1,
      expect: () => [
        isA<StatisticsState>()
            .having((s) => s.selectedMonth.month, 'month', 2)
            .having((s) => s.status, 'status', StatisticsStatus.loading),
        isA<StatisticsState>().having(
          (s) => s.status,
          'status',
          StatisticsStatus.loaded,
        ),
      ],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'StatisticsMonthStepRequested does not move past current month',
      build: () => StatisticsBloc(stockRepository: mockRepo),
      seed: () {
        final now = DateTime.now();
        return StatisticsState(
          selectedMonth: DateTime(now.year, now.month),
          status: StatisticsStatus.loaded,
          stats: const MonthlyStats.empty(),
        );
      },
      act: (bloc) => bloc.add(const StatisticsMonthStepRequested(1)),
      // skip 1: constructor's load emits before act; the step is then blocked
      skip: 1,
      expect: () => [],
    );

    blocTest<StatisticsBloc, StatisticsState>(
      'StatisticsLoadRequested reloads for selected month',
      build: () => StatisticsBloc(stockRepository: mockRepo),
      seed: () => StatisticsState(
        selectedMonth: DateTime(2024),
        status: StatisticsStatus.loaded,
        stats: const MonthlyStats.empty(),
      ),
      act: (bloc) => bloc.add(const StatisticsLoadRequested()),
      // skip 1: constructor's load fires first
      skip: 1,
      expect: () => [
        isA<StatisticsState>().having(
          (s) => s.status,
          'status',
          StatisticsStatus.loaded,
        ),
      ],
    );
  });

  group('MonthlyStats', () {
    test('empty has zero totals', () {
      const stats = MonthlyStats.empty();
      expect(stats.totalIncoming, 0);
      expect(stats.totalOutgoing, 0);
      expect(stats.recycledSavings, 0);
      expect(stats.items, isEmpty);
    });

    test('fromTransactions correctly sums incoming and outgoing', () {
      final stats = MonthlyStats.fromTransactions(
        transactions: [
          _makeTx(amount: 10),
          _makeTx(amount: -4),
          _makeTx(amount: 2),
        ],
      );
      expect(stats.totalIncoming, 12);
      expect(stats.totalOutgoing, 4);
      expect(stats.items.length, 3);
    });

    test(
      'fromTransactions calculates recycledSavings for outgoing recycled',
      () {
        final stats = MonthlyStats.fromTransactions(
          transactions: [
            _makeTx(amount: -2, isRecycledPart: true, unitPriceSnapshot: 5),
          ],
        );
        expect(stats.recycledSavings, closeTo(10.0, 0.001));
      },
    );

    test(
      'fromTransactions does not count incoming recycled parts as savings',
      () {
        final stats = MonthlyStats.fromTransactions(
          transactions: [
            _makeTx(amount: 3, isRecycledPart: true, unitPriceSnapshot: 5),
          ],
        );
        expect(stats.recycledSavings, 0);
      },
    );

    test('fromTransactions sorts newest first', () {
      final older = DateTime(2024, 3);
      final newer = DateTime(2024, 3, 15);
      final stats = MonthlyStats.fromTransactions(
        transactions: [
          _makeTx(amount: 1, partName: 'OlderPart', timestamp: older),
          _makeTx(amount: 1, partName: 'NewerPart', timestamp: newer),
        ],
      );
      expect(stats.items.first.partName, 'NewerPart');
      expect(stats.items.last.partName, 'OlderPart');
    });

    test('fromTransactions uses partId as fallback when partName is empty', () {
      final dto = TransactionDto(
        id: 'tx1',
        partId: 'fallback-id',
        storageId: 's1',
        userId: 'u1',
        amount: 1,
        type: TransactionType.restock,
        note: '',
        timestamp: DateTime(2024, 3),
      );
      final stats = MonthlyStats.fromTransactions(
        transactions: [Transaction.fromDto(dto)],
      );
      expect(stats.items.first.partName, 'fallback-id');
    });
  });

  group('StatisticsState', () {
    test('initial has loading status and current month', () {
      final state = StatisticsState.initial();
      final now = DateTime.now();
      expect(state.status, StatisticsStatus.loading);
      expect(state.selectedMonth.year, now.year);
      expect(state.selectedMonth.month, now.month);
      expect(state.error, isNull);
    });

    test('copyWith replaces fields', () {
      final state = StatisticsState.initial();
      final updated = state.copyWith(
        status: StatisticsStatus.loaded,
        stats: const MonthlyStats.empty(),
      );
      expect(updated.status, StatisticsStatus.loaded);
    });

    test('copyWith with clearError removes existing error', () {
      final state = StatisticsState(
        selectedMonth: DateTime(2024, 3),
        status: StatisticsStatus.error,
        stats: const MonthlyStats.empty(),
        error: Exception('fail'),
      );
      final cleared = state.copyWith(clearError: true);
      expect(cleared.error, isNull);
    });
  });
}
