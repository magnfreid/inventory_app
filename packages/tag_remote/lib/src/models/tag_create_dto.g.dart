// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagCreateDto _$TagCreateDtoFromJson(Map<String, dynamic> json) => TagCreateDto(
  label: json['label'] as String,
  color: $enumDecode(_$TagColorEnumMap, json['color']),
);

Map<String, dynamic> _$TagCreateDtoToJson(TagCreateDto instance) =>
    <String, dynamic>{
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
