// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryItem _$InventoryItemFromJson(Map<String, dynamic> json) =>
    InventoryItem(
      storageId: json['storageId'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$InventoryItemToJson(InventoryItem instance) =>
    <String, dynamic>{
      'storageId': instance.storageId,
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
