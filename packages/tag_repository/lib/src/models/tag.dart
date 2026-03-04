import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/src/models/tag_color.dart';
import 'package:tag_repository/src/models/tag_type.dart';

class Tag {
  Tag({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  factory Tag.fromDto(TagDto dto) {
    final color = TagColor.values.firstWhere(
      (val) => val.name == dto.color,
      orElse: () => TagColor.red,
    );
    final type = TagType.values.firstWhere(
      (val) => val.name == dto.type,
      orElse: () => TagType.general,
    );
    return Tag(id: dto.id ?? '', label: dto.label, color: color, type: type);
  }

  TagDto toDto() =>
      TagDto(id: id, label: label, color: color.name, type: type.name);

  final String id;
  final String label;
  final TagColor color;
  final TagType type;
}
