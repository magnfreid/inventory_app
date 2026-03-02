// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagCreateDto _$TagCreateDtoFromJson(Map<String, dynamic> json) => TagCreateDto(
  label: json['label'] as String,
  color: $enumDecode(_$TagColorEnumMap, json['color']),
  type: $enumDecode(_$TagTypeEnumMap, json['type']),
);

Map<String, dynamic> _$TagCreateDtoToJson(TagCreateDto instance) =>
    <String, dynamic>{
      'label': instance.label,
      'color': _$TagColorEnumMap[instance.color]!,
      'type': _$TagTypeEnumMap[instance.type]!,
    };

const _$TagColorEnumMap = {
  TagColor.red: 'red',
  TagColor.crimson: 'crimson',
  TagColor.orange: 'orange',
  TagColor.deepOrange: 'deepOrange',
  TagColor.amber: 'amber',
  TagColor.yellow: 'yellow',
  TagColor.lime: 'lime',
  TagColor.green: 'green',
  TagColor.lightGreen: 'lightGreen',
  TagColor.emerald: 'emerald',
  TagColor.blue: 'blue',
  TagColor.lightBlue: 'lightBlue',
  TagColor.indigo: 'indigo',
  TagColor.navy: 'navy',
  TagColor.cyan: 'cyan',
  TagColor.teal: 'teal',
  TagColor.purple: 'purple',
  TagColor.deepPurple: 'deepPurple',
  TagColor.violet: 'violet',
  TagColor.pink: 'pink',
  TagColor.rose: 'rose',
};

const _$TagTypeEnumMap = {
  TagType.brand: 'brand',
  TagType.category: 'main',
  TagType.general: 'standard',
};
