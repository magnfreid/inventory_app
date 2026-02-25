import 'package:stock_remote_data_source/src/models/stock_dto.dart';

abstract interface class StockRemoteDataSource {
  Stream<List<StockDto>> watchStock();
  Future<void> increaseStock(String partId, String storageId, int amount);
  Future<void> decreaseStock(String partId, String storageId, int amount);
}
