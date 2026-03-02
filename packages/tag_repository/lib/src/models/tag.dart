import 'package:tag_remote/tag_remote.dart';

class Tag {
  Tag({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  factory Tag.fromDto(TagDto dto) =>
      Tag(id: dto.id, label: dto.label, color: dto.color, type: dto.type);

  final String id;
  final String label;
  final TagColor color;
  final TagType type;

  TagCreateDto toCreateDto() =>
      TagCreateDto(label: label, color: color, type: type);
}
