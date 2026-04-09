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

  /// Moves stock from one storage to another.
  transfer,
}

/// Data Transfer Object (DTO) representing a stock transaction.
///
/// This model is used for serialization/deserialization when communicating
/// with external data sources such as Firebase.
///
/// A transaction represents a single change to stock for a given [partId]
/// and [storageId]. Denormalized display and pricing fields are snapshotted at
/// write time so reads do not require joins or extra collection access.
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
    this.userDisplayName = '',
    this.partName = '',
    this.detailNumber = '',
    this.storageName = '',
    this.unitPriceSnapshot = 0,
    this.isRecycledPart = false,
    this.destinationStorageId,
    this.destinationStorageName,
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

  /// Display name of the user at write time (denormalized).
  @JsonKey(defaultValue: '')
  final String userDisplayName;

  /// Part name at write time (denormalized).
  @JsonKey(defaultValue: '')
  final String partName;

  /// Part detail/article number at write time (denormalized).
  @JsonKey(defaultValue: '')
  final String detailNumber;

  /// Storage location name at write time (denormalized).
  @JsonKey(defaultValue: '')
  final String storageName;

  /// Part unit price at write time; does not change if catalog price changes.
  @JsonKey(defaultValue: 0)
  final double unitPriceSnapshot;

  /// Whether the part was marked recycled at write time.
  @JsonKey(defaultValue: false)
  final bool isRecycledPart;

  /// Destination storage identifier for transfer transactions.
  ///
  /// Only set when [type] is [TransactionType.transfer]; `null` for all other
  /// transaction types.
  final String? destinationStorageId;

  /// Destination storage name snapshotted at write time for transfer
  /// transactions.
  ///
  /// Only set when [type] is [TransactionType.transfer]; `null` for all other
  /// transaction types.
  final String? destinationStorageName;

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
    String? userDisplayName,
    String? partName,
    String? detailNumber,
    String? storageName,
    double? unitPriceSnapshot,
    bool? isRecycledPart,
    int? amount,
    TransactionType? type,
    String? note,
    DateTime? timestamp,
    String? destinationStorageId,
    String? destinationStorageName,
  }) {
    return TransactionDto(
      id: id ?? this.id,
      partId: partId ?? this.partId,
      storageId: storageId ?? this.storageId,
      userId: userId ?? this.userId,
      userDisplayName: userDisplayName ?? this.userDisplayName,
      partName: partName ?? this.partName,
      detailNumber: detailNumber ?? this.detailNumber,
      storageName: storageName ?? this.storageName,
      unitPriceSnapshot: unitPriceSnapshot ?? this.unitPriceSnapshot,
      isRecycledPart: isRecycledPart ?? this.isRecycledPart,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
      destinationStorageId:
          destinationStorageId ?? this.destinationStorageId,
      destinationStorageName:
          destinationStorageName ?? this.destinationStorageName,
    );
  }
}
