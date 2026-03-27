import 'package:freezed_annotation/freezed_annotation.dart';

part 'part_dto.freezed.dart';
part 'part_dto.g.dart';

/// Data Transfer Object (DTO) for Part entity.
///
/// Used for JSON serialization between the app and backend.
@freezed
abstract class PartDto with _$PartDto {
  /// Creates a [PartDto].
  const factory PartDto({
    /// Part name
    required String name,

    /// Unique detail / part number
    required String detailNumber,

    /// Whether the part is made from recycled materials
    required bool isRecycled,

    /// Price of the part
    required double price,

    /// Optional category tag ID
    required String? categoryTagId,

    /// Optional brand tag ID
    required String? brandTagId,

    /// Optional part description
    required String? description,

    /// List of general tag IDs
    required List<String> generalTagIds,

    /// Optional image path / URL
    required String? imgPath,

    /// Optional unique ID (used when received from backend)
    required String? id,
  }) = _PartDto;

  const PartDto._();

  /// Creates [PartDto] from JSON map.
  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);
}
