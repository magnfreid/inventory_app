// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartCreateDto _$PartCreateDtoFromJson(Map<String, dynamic> json) =>
    PartCreateDto(
      name: json['name'] as String,
      detailNumber: json['detailNumber'] as String,
      isRecycled: json['isRecycled'] as bool,
      price: (json['price'] as num).toDouble(),
      brand: json['brand'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PartCreateDtoToJson(PartCreateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'detailNumber': instance.detailNumber,
      'isRecycled': instance.isRecycled,
      'price': instance.price,
      'brand': instance.brand,
      'description': instance.description,
    };
