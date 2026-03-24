import 'package:stock_remote/stock_remote.dart';

///Interface for [StockDto] remote data source.
abstract interface class StockRemote {
  ///Returns a [Stream] of a [List] of [StockDto].
  Stream<List<StockDto>> watchStock();

  Stream<List<TransactionDto>> watchTransactions();

  Future<void> applyStockChange(TransactionDto transaction);
}
