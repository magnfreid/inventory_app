// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockDto _$StockDtoFromJson(Map<String, dynamic> json) => StockDto(
  partId: json['partId'] as String,
  storageId: json['storageId'] as String,
  quantity: (json['quantity'] as num).toInt(),
);

Map<String, dynamic> _$StockDtoToJson(StockDto instance) => <String, dynamic>{
  'partId': instance.partId,
  'storageId': instance.storageId,
  'quantity': instance.quantity,
};
