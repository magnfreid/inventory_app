import 'package:core_remote/core_remote.dart';
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

  //TODO(magnfreid): Add sharedReplay!

  /// Returns a [Stream] of all [Stock] entries.
  ///
  /// Maps the [StockDto]s from [_remote] to [Stock] domain models.
  Stream<List<Stock>> watchStock() {
    return _remote
        .watchStock()
        .map(
          (dtos) => dtos.map(Stock.fromDto).toList(),
        )
        //
        // ignore: inference_failure_on_untyped_parameter
        .handleError((e) {
          if (e is RemoteException) {
            throw e;
          } else {
            throw const UnknownRemoteException();
          }
        });
  }

  /// Increases stock for a part at a specific storage location by [amount].
  Future<void> increaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) async {
    try {
      await _remote.increaseStock(partId, storageId, amount);
    } on RemoteException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }

  /// Decreases stock for a part at a specific storage location by [amount].
  Future<void> decreaseStock({
    required String partId,
    required String storageId,
    required int amount,
  }) async {
    try {
      await _remote.decreaseStock(partId, storageId, amount);
    } on RemoteException catch (_) {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }
}
