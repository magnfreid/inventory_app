import 'package:tag_remote/tag_remote.dart';

class Tag {
  Tag({required this.id, required this.label, required this.color});

  factory Tag.fromDto(TagDto dto) =>
      Tag(id: dto.id, label: dto.label, color: dto.color);

  final String id;
  final String label;
  final TagColor color;

  TagCreateDto toCreateDto() => TagCreateDto(label: label, color: color);
}
