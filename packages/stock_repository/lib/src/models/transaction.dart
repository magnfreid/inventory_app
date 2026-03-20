import 'package:stock_remote/stock_remote.dart';

class Transaction {
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

  factory Transaction.use({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    required String note,
  }) {
    assert(amount > 0);
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

  factory Transaction.restock({
    required String partId,
    required String storageId,
    required String userId,
    required int amount,
    String? note,
  }) {
    assert(amount > 0);
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

  final String id;
  final String partId;
  final String storageId;
  final String userId;
  final int amount;
  final TransactionType type;
  final String? note;
  final DateTime timestamp;

  Transaction fromDto(TransactionDto dto) => Transaction._(
    id: dto.id ?? '',
    partId: dto.partId,
    storageId: dto.storageId,
    userId: dto.userId,
    amount: dto.amount,
    type: dto.type,
    timestamp: dto.timestamp,
    note: dto.note,
  );

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
