import 'package:tag_remote/tag_remote.dart';
import 'package:tag_repository/src/models/tag_color.dart';
import 'package:tag_repository/src/models/tag_type.dart';

/// Domain model representing a tag with a label, color, and type.
class Tag {
  /// Creates a [Tag] instance.
  Tag({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  /// Creates a [Tag] from a [TagDto].
  ///
  /// If the dto color or dto type do not match any enum value,
  /// defaults to [TagColor.red] and [TagType.general].
  factory Tag.fromDto(TagDto dto) {
    final color = TagColor.values.firstWhere(
      (val) => val.name == dto.color,
      orElse: () => TagColor.red,
    );
    final type = TagType.values.firstWhere(
      (val) => val.name == dto.type,
      orElse: () => TagType.general,
    );
    return Tag(id: dto.id, label: dto.label, color: color, type: type);
  }

  /// Converts this [Tag] to a [TagDto].
  TagDto toDto() =>
      TagDto(id: id, label: label, color: color.name, type: type.name);

  /// Unique ID of the tag.
  final String? id;

  /// Display label of the tag.
  final String label;

  /// Color of the tag.
  final TagColor color;

  /// Type/category of the tag.
  final TagType type;
}
