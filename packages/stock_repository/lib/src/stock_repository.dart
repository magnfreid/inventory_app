import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/stock_repository.dart';

/// Repository responsible for managing [Stock] domain models.
///
/// Wraps a [StockRemote] data source and maps [StockDto]s to [Stock]s.
class StockRepository {
  /// Creates a [StockRepository] using the provided [remote] data source.
  StockRepository({
    required StockRemote remote,
  }) : _remote = remote;

  final StockRemote _remote;

  /// Returns a [Stream] of all [Stock] entries.
  ///
  /// Maps the [StockDto]s from [_remote] to [Stock] domain models.
  Stream<List<Stock>> watchStock() {
    return _remote.watchStock().map(
      (dtos) => dtos.map(Stock.fromDto).toList(),
    );
  }

  /// Increases stock for a part at a specific storage location by [amount].
  ///
  /// Throws an [ArgumentError] if [amount] is less than or equal to 0.
  Future<void> increaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) {
    return _remote.increaseStock(partId, storageId, amount);
  }

  /// Decreases stock for a part at a specific storage location by [amount].
  ///
  /// Throws an [ArgumentError] if [amount] is less than or equal to 0.
  Future<void> decreaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) {
    return _remote.decreaseStock(partId, storageId, amount);
  }
}
