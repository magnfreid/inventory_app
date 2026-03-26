import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:part_remote/part_remote.dart';
part 'part.freezed.dart';

/// Domain model representing a [Part] in the system.
@freezed
abstract class Part with _$Part {
  /// Creates a [Part] instance.
  const factory Part({
    required String? id,
    required String name,
    required String detailNumber,
    required double price,
    required bool isRecycled,
    required List<String> generalTagIds,
    required String? brandTagId,
    required String? categoryTagId,
    required String? description,
    required String? imgPath,
  }) = _Part;

  const Part._();

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
    imgPath: dto.imgPath,
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
    imgPath: imgPath,
  );
}
