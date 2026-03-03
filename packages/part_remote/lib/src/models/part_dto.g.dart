// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartDto _$PartDtoFromJson(Map<String, dynamic> json) => PartDto(
  id: json['id'] as String,
  name: json['name'] as String,
  detailNumber: json['detailNumber'] as String,
  isRecycled: json['isRecycled'] as bool,
  price: (json['price'] as num).toDouble(),
  categoryTagId: json['mainTagId'] as String?,
  description: json['description'] as String?,
  brandTagId: json['brandTagId'] as String?,
  generalTagIds: (json['standardTagIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$PartDtoToJson(PartDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'detailNumber': instance.detailNumber,
  'isRecycled': instance.isRecycled,
  'price': instance.price,
  'mainTagId': instance.categoryTagId,
  'brandTagId': instance.brandTagId,
  'standardTagIds': instance.generalTagIds,
  'description': instance.description,
};
