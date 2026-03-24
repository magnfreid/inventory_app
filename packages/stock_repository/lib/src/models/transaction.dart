import 'package:stock_remote/stock_remote.dart';

/// Domain model representing a stock transaction.
class Transaction {
  /// Creates a [Transaction] from a [TransactionDto].
  factory Transaction.fromDto(TransactionDto dto) => Transaction._(
    id: dto.id ?? '',
    partId: dto.partId,
    storageId: dto.storageId,
    userId: dto.userId,
    amount: dto.amount,
    type: dto.type,
    timestamp: dto.timestamp,
    note: dto.note,
  );

  Transaction._({
    required this.id,
    required this.partId,
    required this.storageId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.timestamp,
    required this.note,
  });

  /// Creates a transaction representing usage of stock.
  ///
  /// The provided [amount] must be greater than zero and will be stored
  /// as a negative value.
  factory Transaction.use({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    required String note,
  }) {
    assert(amount > 0, 'amount must be > 0 for Transaction.use');
    return Transaction._(
      id: '',
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: -amount,
      type: .use,
      note: note,
      timestamp: DateTime.now(),
    );
  }

  /// Creates a transaction representing a restock operation.
  ///
  /// The provided [amount] must be greater than zero.
  factory Transaction.restock({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    String? note,
  }) {
    assert(amount > 0, 'amount must be > 0 for Transaction.restock');
    return Transaction._(
      id: '',
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: amount,
      type: .restock,
      timestamp: DateTime.now(),
      note: note,
    );
  }

  /// Creates a transaction representing a manual adjustment.
  ///
  /// The [amount] may be positive or negative depending on the adjustment.
  factory Transaction.adjustment({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    required String note,
  }) {
    return Transaction._(
      id: '',
      partId: partId,
      storageId: storageId,
      userId: userId,
      amount: amount,
      type: .adjustment,
      note: note,
      timestamp: DateTime.now(),
    );
  }

  /// Unique identifier of the transaction.
  final String id;

  /// Identifier of the associated part.
  final String partId;

  /// Identifier of the storage location.
  final String storageId;

  /// Identifier of the user who performed the transaction.
  final String userId;

  /// The amount applied to the stock.
  ///
  /// Positive values increase stock, negative values decrease it.
  final int amount;

  /// Type of the transaction.
  final TransactionType type;

  /// Optional note associated with the transaction.
  final String? note;

  /// Timestamp of when the transaction was created.
  final DateTime timestamp;

  /// Converts this [Transaction] into a [TransactionDto].
  TransactionDto toDto() => TransactionDto(
    id: null,
    partId: partId,
    storageId: storageId,
    userId: userId,
    amount: amount,
    type: type,
    note: note,
    timestamp: timestamp,
  );
}
