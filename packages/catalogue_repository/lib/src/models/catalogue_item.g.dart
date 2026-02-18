// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalogue_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogueItem _$CatalogueItemFromJson(Map<String, dynamic> json) =>
    CatalogueItem(
      id: json['id'] as String,
      name: json['name'] as String,
      detailNumber: json['detailNumber'] as String,
      isRecycled: json['isRecycled'] as bool,
      price: (json['price'] as num).toDouble(),
      brand: json['brand'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CatalogueItemToJson(CatalogueItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'detailNumber': instance.detailNumber,
      'isRecycled': instance.isRecycled,
      'price': instance.price,
      'brand': instance.brand,
      'description': instance.description,
    };
