import 'package:json_annotation/json_annotation.dart';

part 'transaction_dto.g.dart';

/// Represents the type of a stock transaction.
enum TransactionType {
  /// Decreases stock (consumption).
  use,

  /// Increases stock.
  restock,

  /// Manual correction (can be positive or negative).
  adjustment,
}

/// Data Transfer Object (DTO) representing a stock transaction.
///
/// This model is used for serialization/deserialization when communicating
/// with external data sources such as Firebase.
///
/// A transaction represents a single change to stock for a given [partId]
/// and [storageId].
@JsonSerializable()
class TransactionDto {
  /// Creates a new [TransactionDto].
  ///
  /// The [id] may be `null` when creating a new transaction locally and is
  /// typically assigned by the backend (e.g. Firestore document ID).
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

  /// Creates a [TransactionDto] from a JSON map.
  ///
  /// Used when deserializing data from a remote source.
  factory TransactionDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionDtoFromJson(json);

  /// Converts this [TransactionDto] into a JSON map.
  ///
  /// Used when sending data to a remote source.
  Map<String, dynamic> toJson() => _$TransactionDtoToJson(this);

  /// Unique identifier of the transaction.
  ///
  /// This is typically the document ID from the backend.
  /// May be `null` before the transaction is persisted.
  final String? id;

  /// Identifier of the part affected by this transaction.
  final String partId;

  /// Identifier of the storage location affected by this transaction.
  final String storageId;

  /// Identifier of the user who performed the transaction.
  final String userId;

  /// The amount of stock change.
  ///
  /// Positive values increase stock, negative values decrease stock.
  final int amount;

  /// The type of transaction.
  ///
  /// Determines how the transaction should be interpreted in the UI/business logic.
  final TransactionType type;

  /// Optional note describing the transaction.
  ///
  /// Can be used for additional context (e.g. reason for adjustment).
  final String? note;

  /// The timestamp when the transaction occurred.
  final DateTime timestamp;

  /// Returns a copy of this [TransactionDto] with updated fields.
  ///
  /// Any parameter that is `null` will keep its current value.
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
