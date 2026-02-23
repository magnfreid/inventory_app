// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationCreateModel _$LocationCreateModelFromJson(Map<String, dynamic> json) =>
    LocationCreateModel(
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LocationCreateModelToJson(
  LocationCreateModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
};
