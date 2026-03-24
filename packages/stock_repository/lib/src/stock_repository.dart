import 'package:core_remote/core_remote.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stock_remote/stock_remote.dart';
import 'package:stock_repository/src/models/transaction.dart';
import 'package:stock_repository/stock_repository.dart';

/// Repository responsible for managing [Stock] and [Transaction] domain models.
///
/// Wraps a [StockRemote] data source and maps [StockDto]s to [Stock]s and
/// [TransactionDto]s to [Transaction]s.
class StockRepository {
  /// Creates a [StockRepository] using the provided [remote] data source.
  StockRepository({
    required StockRemote remote,
  }) : _remote = remote;

  final StockRemote _remote;

  /// Returns a [Stream] of all [Stock] entries.
  ///
  /// Maps the [StockDto]s from the remote data source to [Stock] domain models.
  /// The latest emitted value is replayed to new subscribers.
  Stream<List<Stock>> watchStock() => _stockStream;

  /// Returns a [Stream] of all [Transaction] entries.
  ///
  /// Maps the [TransactionDto]s from the remote data source to [Transaction]
  /// domain models. The latest emitted value is replayed to new subscribers.
  Stream<List<Transaction>> watchTransactions() => _transactionsStream;

  /// Decreases the stock of a part by one unit.
  ///
  /// Creates a usage [Transaction] and applies it through the remote data
  /// source.
  ///
  /// Rethrows [RemoteException] and wraps other exceptions in
  /// [UnknownRemoteException].
  Future<void> useStock({
    required String partId,
    required String storageId,
    required String userId,
    required String note,
  }) async {
    final transaction = Transaction.use(
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: 1,
      note: note,
    );

    try {
      await _remote.applyStockChange(transaction.toDto());
    } on RemoteException {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }

  /// Increases the stock of a part by the given [amount].
  ///
  /// Creates a restock [Transaction] and applies it through the remote data
  /// source.
  /// Rethrows [RemoteException] and wraps other exceptions in
  /// [UnknownRemoteException].
  Future<void> restockStock({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    String? note,
  }) async {
    final transaction = Transaction.restock(
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: amount,
      note: note,
    );

    try {
      await _remote.applyStockChange(transaction.toDto());
    } on RemoteException {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }

  /// Adjusts the stock of a part by the given [amount].
  ///
  /// The [amount] may be positive or negative depending on the adjustment.
  /// Creates an adjustment [Transaction] and applies it through the remote
  /// data source.
  ///
  /// Rethrows [RemoteException] and wraps other exceptions in
  /// [UnknownRemoteException].
  Future<void> adjustStock({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    required String note,
  }) async {
    final transaction = Transaction.adjustment(
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: amount,
      note: note,
    );

    try {
      await _remote.applyStockChange(transaction.toDto());
    } on RemoteException {
      rethrow;
    } on Exception catch (_) {
      throw const UnknownRemoteException();
    }
  }

  /// Internal shared stream of [Stock] entries.
  ///
  /// Uses `shareReplay` to cache the latest value and avoid multiple
  /// subscriptions to the underlying remote stream.
  late final Stream<List<Stock>> _stockStream = _remote
      .watchStock()
      .map(
        (dtos) => dtos.map(Stock.fromDto).toList(),
      )
      .shareReplay(maxSize: 1)
      //
      // ignore: inference_failure_on_untyped_parameter
      .handleError((e) {
        if (e is RemoteException) {
          throw e;
        } else {
          throw const UnknownRemoteException();
        }
      });

  /// Internal shared stream of [Transaction] entries.
  ///
  /// Uses `shareReplay` to cache the latest value and avoid multiple
  /// subscriptions to the underlying remote stream.
  late final Stream<List<Transaction>> _transactionsStream = _remote
      .watchTransactions()
      .map(
        (dtos) => dtos.map(Transaction.fromDto).toList(),
      )
      .shareReplay(maxSize: 1)
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
