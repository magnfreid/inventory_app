import 'package:json_annotation/json_annotation.dart';

part 'stock_dto.g.dart';

/// Data Transfer Object representing stock for a part at a specific storage
/// location.
@JsonSerializable()
class StockDto {
  /// Creates a [StockDto] instance.
  StockDto({
    required this.partId,
    required this.storageId,
    required this.quantity,
  });

  /// Creates a [StockDto] from a JSON map.
  factory StockDto.fromJson(Map<String, dynamic> json) =>
      _$StockDtoFromJson(json);

  /// Converts this [StockDto] to a JSON map.
  Map<String, dynamic> toJson() => _$StockDtoToJson(this);

  /// The ID of the part associated with this stock entry.
  final String partId;

  /// The ID of the storage location for this stock entry.
  final String storageId;

  /// Quantity of the part available at this storage location.
  final int quantity;

  StockDto copyWith({
    String? partId,
    String? storageId,
    int? quantity,
  }) {
    return StockDto(
      partId: partId ?? this.partId,
      storageId: storageId ?? this.storageId,
      quantity: quantity ?? this.quantity,
    );
  }
}
