import 'package:json_annotation/json_annotation.dart';

part 'inventory_item.g.dart';

@JsonSerializable()
class InventoryItem {
  InventoryItem({
    required this.locationId,
    required this.productId,
    required this.quantity,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) =>
      _$InventoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryItemToJson(this);

  final String locationId;
  final String productId;
  final int quantity;
}
