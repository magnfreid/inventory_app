import 'package:json_annotation/json_annotation.dart';
import 'package:tag_remote/tag_remote.dart';

part 'tag_create_dto.g.dart';

@JsonSerializable()
class TagCreateDto {
  TagCreateDto({required this.label, required this.color, required this.type});

  factory TagCreateDto.fromJson(Map<String, dynamic> json) =>
      _$TagCreateDtoFromJson(json);
  final String label;
  final TagColor color;
  final TagType type;

  Map<String, dynamic> toJson() => _$TagCreateDtoToJson(this);
}
