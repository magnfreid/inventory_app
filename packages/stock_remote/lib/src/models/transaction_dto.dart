import 'package:json_annotation/json_annotation.dart';

part 'transaction_dto.g.dart';

enum TransactionType { use, restock, adjustment }

@JsonSerializable()
class TransactionDto {
  TransactionDto({
    required this.id,
    required this.partId,
    required this.storageId,
    required this.userId,
    required this.amount,
    required this.type,
    required this.note,
    required this.timestamp,
  });

  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionDtoToJson(this);

  final String? id;
  final String partId;
  final String storageId;
  final String userId;
  final int amount;
  final TransactionType type;
  final String? note;
  final DateTime timestamp;

  TransactionDto copyWith({
    String? id,
    String? partId,
    String? storageId,
    String? userId,
    int? amount,
    TransactionType? type,
    String? note,
    DateTime? timestamp,
  }) {
    return TransactionDto(
      id: id ?? this.id,
      partId: partId ?? this.partId,
      storageId: storageId ?? this.storageId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
