// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageCreateModel _$StorageCreateModelFromJson(Map<String, dynamic> json) =>
    StorageCreateModel(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$StorageCreateModelToJson(StorageCreateModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };
