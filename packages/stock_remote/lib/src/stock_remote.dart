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

  /// Applies a stock change based on the given [transaction].
  ///
  /// The [TransactionDto.amount] determines how the stock is affected.
  Future<void> applyStockChange(TransactionDto transaction);
}
