import 'package:json_annotation/json_annotation.dart';

part 'part_dto.g.dart';

@JsonSerializable()
/// Data Transfer Object representing a `Part` in the system.
class PartDto {
  /// Creates a [PartDto] instance.
  PartDto({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.categoryTagId,
    required this.description,
    required this.brandTagId,
    required this.generalTagIds,
    required this.imgPath,
  });

  /// Creates a [PartDto] from a JSON map.
  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);

  /// Converts this [PartDto] to a JSON map.
  Map<String, dynamic> toJson() => _$PartDtoToJson(this);

  /// Creates a copy of this [PartDto] with optional new values.
  PartDto copyWith({
    String? id,
    String? name,
    String? detailNumber,
    bool? isRecycled,
    double? price,
    String? categoryTagId,
    String? brandTagId,
    List<String>? generalTagIds,
    String? description,
    String? imgPath,
  }) {
    return PartDto(
      id: id ?? this.id,
      name: name ?? this.name,
      detailNumber: detailNumber ?? this.detailNumber,
      isRecycled: isRecycled ?? this.isRecycled,
      price: price ?? this.price,
      categoryTagId: categoryTagId ?? this.categoryTagId,
      brandTagId: brandTagId ?? this.brandTagId,
      generalTagIds: generalTagIds ?? this.generalTagIds,
      description: description ?? this.description,
      imgPath: imgPath ?? this.imgPath,
    );
  }

  /// Unique identifier of the part.
  final String? id;

  /// Name of the part.
  final String name;

  /// Detail or catalog number of the part.
  final String detailNumber;

  /// Indicates if the part is recycled.
  final bool isRecycled;

  /// Price of the part.
  final double price;

  /// Optional category tag ID associated with the part.
  final String? categoryTagId;

  /// Optional brand tag ID associated with the part.
  final String? brandTagId;

  /// Optional description of the part.
  final String? description;

  /// List of IDs for general tags associated with the part.
  final List<String> generalTagIds;

  final String? imgPath;
}
