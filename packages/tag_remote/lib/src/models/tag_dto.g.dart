// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagDto _$TagDtoFromJson(Map<String, dynamic> json) => TagDto(
  id: json['id'] as String,
  label: json['label'] as String,
  color: $enumDecode(_$TagColorEnumMap, json['color']),
);

Map<String, dynamic> _$TagDtoToJson(TagDto instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'color': _$TagColorEnumMap[instance.color]!,
};

const _$TagColorEnumMap = {
  TagColor.red: 'red',
  TagColor.blue: 'blue',
  TagColor.yellow: 'yellow',
  TagColor.green: 'green',
  TagColor.white: 'white',
  TagColor.black: 'black',
  TagColor.purple: 'purple',
  TagColor.cyan: 'cyan',
};
