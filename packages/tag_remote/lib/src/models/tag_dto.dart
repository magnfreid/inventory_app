import 'package:json_annotation/json_annotation.dart';

part 'tag_dto.g.dart';

/// Data Transfer Object representing a tag in the remote source.
@JsonSerializable()
class TagDto {
  /// Creates a [TagDto].
  ///
  /// [id] is optional and typically assigned by the remote database.
  TagDto({
    required this.id,
    required this.label,
    required this.color,
    required this.type,
  });

  /// Creates a [TagDto] from a JSON map.
  factory TagDto.fromJson(Map<String, dynamic> json) => _$TagDtoFromJson(json);

  /// The remote-assigned ID of the tag.
  final String? id;

  /// Label of the tag (human-readable name).
  final String label;

  /// Color of the tag as a string (e.g., 'red', 'blue').
  final String color;

  /// Type/category of the tag as a string.
  final String type;

  /// Converts this [TagDto] to a JSON map.
  Map<String, dynamic> toJson() => _$TagDtoToJson(this);

  /// Creates a copy of this [TagDto] with optional updated fields.
  TagDto copyWith({String? id, String? label, String? color, String? type}) =>
      TagDto(
        id: id ?? this.id,
        label: label ?? this.label,
        color: color ?? this.color,
        type: type ?? this.type,
      );
}
