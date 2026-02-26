import 'models/stock_dto.dart';

abstract interface class StockRemote {
  Stream<List<StockDto>> watchStock();
  Future<void> increaseStock(String partId, String storageId, int amount);
  Future<void> decreaseStock(String partId, String storageId, int amount);
}
