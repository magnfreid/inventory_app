// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageDto _$StorageDtoFromJson(Map<String, dynamic> json) => StorageDto(
  id: json['id'] as String?,
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$StorageDtoToJson(StorageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
