// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stock _$StockFromJson(Map<String, dynamic> json) => Stock(
  storageId: json['storageId'] as String,
  partId: json['partId'] as String,
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$StockToJson(Stock instance) => <String, dynamic>{
  'storageId': instance.storageId,
  'partId': instance.partId,
  'quantity': instance.quantity,
};
