// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PartDto _$PartDtoFromJson(Map<String, dynamic> json) => _PartDto(
  name: json['name'] as String,
  detailNumber: json['detailNumber'] as String,
  isRecycled: json['isRecycled'] as bool,
  price: (json['price'] as num).toDouble(),
  categoryTagId: json['categoryTagId'] as String?,
  brandTagId: json['brandTagId'] as String?,
  description: json['description'] as String?,
  generalTagIds: (json['generalTagIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  imgPath: json['imgPath'] as String?,
  thumbnailPath: json['thumbnailPath'] as String?,
  id: json['id'] as String?,
);

Map<String, dynamic> _$PartDtoToJson(_PartDto instance) => <String, dynamic>{
  'name': instance.name,
  'detailNumber': instance.detailNumber,
  'isRecycled': instance.isRecycled,
  'price': instance.price,
  'categoryTagId': instance.categoryTagId,
  'brandTagId': instance.brandTagId,
  'description': instance.description,
  'generalTagIds': instance.generalTagIds,
  'imgPath': instance.imgPath,
  'thumbnailPath': instance.thumbnailPath,
  'id': instance.id,
};
