import 'package:freezed_annotation/freezed_annotation.dart';

part 'part_dto.freezed.dart';
part 'part_dto.g.dart';

@freezed
abstract class PartDto with _$PartDto {
  const factory PartDto({
    required String name,
    required String detailNumber,
    required bool isRecycled,
    required double price,
    required String? categoryTagId,
    required String? brandTagId,
    required String? description,
    required List<String> generalTagIds,
    required String? imgPath,
    String? id,
  }) = _PartDto;

  const PartDto._();

  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);
}
