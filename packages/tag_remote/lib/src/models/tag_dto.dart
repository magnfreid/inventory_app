import 'package:json_annotation/json_annotation.dart';

part 'tag_dto.g.dart';

@JsonSerializable()
class TagDto {
  TagDto({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String label;
  final String color;
  final String type;

  Map<String, dynamic> toJson() => _$TagDtoToJson(this);

  TagDto copyWith({String? id, String? label, String? color, String? type}) =>
      TagDto(
        id: id ?? this.id,
        label: label ?? this.label,
        color: color ?? this.color,
        type: type ?? this.type,
      );
}
