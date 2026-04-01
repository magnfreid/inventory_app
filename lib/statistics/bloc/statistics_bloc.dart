import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:stock_repository/stock_repository.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

/// Loads and aggregates stock [Transaction] data per calendar month for the UI.
///
/// Fetches one month at a time via [StockRepository.fetchTransactionsForMonth];
/// transaction documents carry denormalized names and price snapshots.
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  /// Creates a bloc that reads transactions from [stockRepository].
  StatisticsBloc({
    required StockRepository stockRepository,
  }) : _stockRepository = stockRepository,
       super(StatisticsState.initial()) {
    on<StatisticsLoadRequested>(_onLoadRequested);
    on<StatisticsMonthChanged>(_onMonthChanged);
    on<StatisticsMonthStepRequested>(_onMonthStepRequested);
    add(const StatisticsLoadRequested());
  }

  final StockRepository _stockRepository;

  FutureOr<void> _onLoadRequested(
    StatisticsLoadRequested event,
    Emitter<StatisticsState> emit,
  ) async {
    await _fetchForSelectedMonth(emit);
  }

  FutureOr<void> _onMonthChanged(
    StatisticsMonthChanged event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedMonth: DateTime(event.month.year, event.month.month),
        status: StatisticsStatus.loading,
        clearError: true,
      ),
    );
    await _fetchForSelectedMonth(emit);
  }

  FutureOr<void> _onMonthStepRequested(
    StatisticsMonthStepRequested event,
    Emitter<StatisticsState> emit,
  ) async {
    final current = state.selectedMonth;
    final target = DateTime(current.year, current.month + event.delta);
    final now = DateTime.now();
    final latestAllowedMonth = DateTime(now.year, now.month);
    if (!target.isAfter(latestAllowedMonth)) {
      emit(
        state.copyWith(
          selectedMonth: DateTime(target.year, target.month),
          status: StatisticsStatus.loading,
          clearError: true,
        ),
      );
      await _fetchForSelectedMonth(emit);
    }
  }

  Future<void> _fetchForSelectedMonth(Emitter<StatisticsState> emit) async {
    try {
      final transactions = await _stockRepository.fetchTransactionsForMonth(
        state.selectedMonth,
      );
      final stats = MonthlyStats.fromTransactions(
        transactions: transactions,
      );
      emit(
        state.copyWith(
          status: StatisticsStatus.loaded,
          stats: stats,
          clearError: true,
        ),
      );
    } on Object catch (e) {
      emit(
        state.copyWith(
          status: StatisticsStatus.error,
          error: e,
        ),
      );
    }
  }
}
