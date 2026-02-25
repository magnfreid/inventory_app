import 'package:stock_remote_data_source/stock_remote_data_source.dart';
import 'package:stock_repository/stock_repository.dart';

class StockRepository {
  StockRepository({
    required StockRemoteDataSource remote,
  }) : _remote = remote;

  final StockRemoteDataSource _remote;

  Stream<List<Stock>> watchStock() {
    return _remote.watchStock().map(
      (dtos) => dtos.map(Stock.fromDto).toList(),
    );
  }

  Future<void> increaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) {
    return _remote.increaseStock(partId, storageId, amount);
  }

  Future<void> decreaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) {
    return _remote.decreaseStock(partId, storageId, amount);
  }
}
