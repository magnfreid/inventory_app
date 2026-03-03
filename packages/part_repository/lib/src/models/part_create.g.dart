// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartCreate _$PartCreateFromJson(Map<String, dynamic> json) => PartCreate(
  name: json['name'] as String,
  detailNumber: json['detailNumber'] as String,
  isRecycled: json['isRecycled'] as bool,
  price: (json['price'] as num).toDouble(),
  categoryTagId: json['mainTagId'] as String?,
  brandTagId: json['brandTagId'] as String?,
  generalTagIds: (json['standardTagIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  description: json['description'] as String?,
);

Map<String, dynamic> _$PartCreateToJson(PartCreate instance) =>
    <String, dynamic>{
      'name': instance.name,
      'detailNumber': instance.detailNumber,
      'isRecycled': instance.isRecycled,
      'price': instance.price,
      'mainTagId': instance.categoryTagId,
      'brandTagId': instance.brandTagId,
      'standardTagIds': instance.generalTagIds,
      'description': instance.description,
    };
