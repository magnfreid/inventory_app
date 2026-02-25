import 'package:stock_repository/src/models/stock.dart';

abstract interface class StockRepository {
  Stream<List<Stock>> watchStock();
  Future<void> increaseStock({
    required String productId,
    required String locationId,
    required int amount,
  });
  Future<void> decreaseStock({
    required String productId,
    required String locationId,
    required int amount,
  });
}
