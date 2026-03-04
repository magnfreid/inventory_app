import 'package:part_remote/part_remote.dart';

/// Domain model representing a [Part] in the system.
class Part {
  /// Creates a [Part] instance.
  Part({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.price,
    required this.isRecycled,
    required this.brandTagId,
    required this.categoryTagId,
    required this.generalTagIds,
    required this.description,
  });

  /// Creates a [Part] from a [PartDto].
  factory Part.fromDto(PartDto dto) => Part(
    id: dto.id,
    name: dto.name,
    detailNumber: dto.detailNumber,
    isRecycled: dto.isRecycled,
    price: dto.price,
    categoryTagId: dto.categoryTagId,
    brandTagId: dto.brandTagId,
    generalTagIds: dto.generalTagIds,
    description: dto.description,
  );

  /// Converts this [Part] to a [PartDto] for persistence.
  PartDto toDto() => PartDto(
    id: id,
    name: name,
    detailNumber: detailNumber,
    isRecycled: isRecycled,
    price: price,
    categoryTagId: categoryTagId,
    description: description,
    brandTagId: brandTagId,
    generalTagIds: generalTagIds,
  );

  /// Unique identifier of the part.
  final String? id;

  /// Name of the part.
  final String name;

  /// Detail or catalog number of the part.
  final String detailNumber;

  /// Price of the part.
  final double price;

  /// Indicates if the part is recycled.
  final bool isRecycled;

  /// Optional brand tag ID associated with the part.
  final String? brandTagId;

  /// Optional category tag ID associated with the part.
  final String? categoryTagId;

  /// List of IDs for general tags associated with the part.
  final List<String> generalTagIds;

  /// Optional description of the part.
  final String? description;
}
