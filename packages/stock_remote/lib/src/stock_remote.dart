import 'package:stock_remote/stock_remote.dart';

///Interface for [StockDto] remote data source.
abstract interface class StockRemote {
  ///Returns a [Stream] of a [List] of [StockDto].
  Stream<List<StockDto>> watchStock();

  ///Increases a stock entry's quantity by [amount].
  Future<void> increaseStock(String partId, String storageId, int amount);

  ///Decreases a stock entry's quantity by [amount] (down to 0).
  Future<void> decreaseStock(String partId, String storageId, int amount);
}
