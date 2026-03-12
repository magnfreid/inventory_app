// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagDto _$TagDtoFromJson(Map<String, dynamic> json) => TagDto(
  id: json['id'] as String?,
  label: json['label'] as String,
  color: json['color'] as String,
  type: json['type'] as String,
);

Map<String, dynamic> _$TagDtoToJson(TagDto instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'color': instance.color,
  'type': instance.type,
};
