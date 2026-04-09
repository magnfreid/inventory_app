import 'package:stock_remote/stock_remote.dart';

/// Interface for a remote data source handling stock and transactions.
///
/// Implementations are responsible for fetching and persisting data
/// from an external source (e.g. a backend service).
abstract interface class StockRemote {
  /// Returns a stream of all stock entries.
  ///
  /// Each emission contains a list of [StockDto] objects representing
  /// the current state of stock.
  Stream<List<StockDto>> watchStock();

  /// Returns a stream of all transactions.
  ///
  /// Each emission contains a list of [TransactionDto] objects.
  Stream<List<TransactionDto>> watchTransactions();

  /// Loads transactions whose [TransactionDto.timestamp] falls in the given
  /// calendar [month] (local date semantics; day-of-month is ignored).
  Future<List<TransactionDto>> fetchTransactionsForMonth(DateTime month);

  /// Applies a stock change based on the given [transaction].
  ///
  /// The [TransactionDto.amount] determines how the stock is affected.
  Future<void> applyStockChange(TransactionDto transaction);

  /// Transfers stock between two storages in a single atomic operation.
  ///
  /// [deductTransaction] records the removal from the source storage and
  /// [addTransaction] records the addition to the destination storage.
  /// Both documents are written — and both stock quantities are updated —
  /// in a single Firestore transaction so the operation is all-or-nothing.
  ///
  /// Throws an invalid-argument exception if the source storage does not
  /// have enough stock to satisfy the transfer.
  Future<void> transferStock({
    required TransactionDto deductTransaction,
    required TransactionDto addTransaction,
  });
}
