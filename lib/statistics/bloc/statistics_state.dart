part of 'statistics_bloc.dart';

/// Whether monthly stats are loading, ready, or failed.
enum StatisticsStatus {
  /// A month fetch is in progress or recomputing after month change.
  loading,

  /// Stats match the selected month.
  loaded,

  /// Fetch failed; see error on state.
  error,
}

/// Immutable UI state for the statistics screen.
class StatisticsState {
  /// Full state for the statistics feature.
  const StatisticsState({
    required this.selectedMonth,
    required this.status,
    required this.stats,
    this.error,
  });

  /// Initial state: current calendar month, loading, empty aggregates.
  factory StatisticsState.initial() {
    final now = DateTime.now();
    return StatisticsState(
      selectedMonth: DateTime(now.year, now.month),
      status: StatisticsStatus.loading,
      stats: const MonthlyStats.empty(),
    );
  }

  /// First day of the month the user is viewing (day should be ignored by UI).
  final DateTime selectedMonth;

  /// High-level load / error status.
  final StatisticsStatus status;

  /// Aggregates and rows for [selectedMonth].
  final MonthlyStats stats;

  /// Set when [status] is [StatisticsStatus.error].
  final Object? error;

  /// Returns a copy with the given fields replaced.
  StatisticsState copyWith({
    DateTime? selectedMonth,
    StatisticsStatus? status,
    MonthlyStats? stats,
    Object? error,
    bool clearError = false,
  }) {
    return StatisticsState(
      selectedMonth: selectedMonth ?? this.selectedMonth,
      status: status ?? this.status,
      stats: stats ?? this.stats,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Precomputed numbers and list rows for one month.
class MonthlyStats {
  /// Creates stats with explicit totals and line items.
  const MonthlyStats({
    required this.items,
    required this.totalIncoming,
    required this.totalOutgoing,
    required this.recycledSavings,
  });

  /// Zeroed stats with no rows (e.g. before first emission).
  const MonthlyStats.empty()
    : items = const [],
      totalIncoming = 0,
      totalOutgoing = 0,
      recycledSavings = 0;

  /// Builds totals and rows from a month query (newest first).
  ///
  /// Uses denormalized fields written on each transaction at stock change time
  /// (part name, unit price snapshot, recycled flag, etc.).
  factory MonthlyStats.fromTransactions({
    required List<Transaction> transactions,
  }) {
    var totalIncoming = 0;
    var totalOutgoing = 0;
    var recycledSavings = 0.0;

    final sorted = [...transactions]
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    final items = sorted.map((transaction) {
      if (transaction.amount > 0) {
        totalIncoming += transaction.amount;
      } else {
        totalOutgoing += -transaction.amount;
      }

      if (transaction.amount < 0 && transaction.isRecycledPart) {
        recycledSavings +=
            (-transaction.amount) * transaction.unitPriceSnapshot;
      }

      return TransactionListItem(
        transaction: transaction,
        partName: transaction.partName.isNotEmpty
            ? transaction.partName
            : transaction.partId,
      );
    }).toList();

    return MonthlyStats(
      items: items,
      totalIncoming: totalIncoming,
      totalOutgoing: totalOutgoing,
      recycledSavings: recycledSavings,
    );
  }

  /// One row per transaction in the month, newest first.
  final List<TransactionListItem> items;

  /// Sum of positive stock deltas in the month.
  final int totalIncoming;

  /// Sum of absolute negative amounts (outgoing quantity) in the month.
  final int totalOutgoing;

  /// Estimated savings from recycled consumption (quantity × snapshot price).
  final double recycledSavings;
}

/// One list row: full transaction plus display title for the part name.
class TransactionListItem {
  /// Creates a row for the transaction list.
  const TransactionListItem({
    required this.transaction,
    required this.partName,
  });

  /// Underlying stock transaction.
  final Transaction transaction;

  /// Display title (snapshotted part name, or id fallback).
  final String partName;
}
