import 'package:json_annotation/json_annotation.dart';
import 'package:tag_remote/tag_remote.dart';

part 'tag_dto.g.dart';

@JsonSerializable()
class TagDto {
  TagDto({required this.id, required this.label, required this.color});

  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);
  factory TagDto.fromCreateModel({
    required TagCreateDto createModel,
    required String id,
  }) => TagDto(id: id, label: createModel.label, color: createModel.color);

  final String id;
  final String label;
  final TagColor color;

  Map<String, dynamic> toJson() => _$TagDtoToJson(this);
}
