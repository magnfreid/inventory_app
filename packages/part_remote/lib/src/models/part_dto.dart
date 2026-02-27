import 'package:json_annotation/json_annotation.dart';
import 'package:part_remote/src/models/models.dart';

part 'part_dto.g.dart';

@JsonSerializable()
class PartDto {
  PartDto({
    required this.id,
    required this.name,
    required this.detailNumber,
    required this.isRecycled,
    required this.price,
    required this.mainTagId,
    required this.description,
  });

  factory PartDto.fromJson(Map<String, dynamic> json) =>
      _$PartDtoFromJson(json);

  factory PartDto.fromCreateModel(String id, PartCreateDto createModel) =>
      PartDto(
        id: id,
        name: createModel.name,
        detailNumber: createModel.detailNumber,
        isRecycled: createModel.isRecycled,
        price: createModel.price,
        mainTagId: createModel.mainTagId,
        description: createModel.description,
      );

  Map<String, dynamic> toJson() => _$PartDtoToJson(this);

  final String id;
  final String name;
  final String detailNumber;
  final bool isRecycled;
  final double price;
  final String? mainTagId;
  final String? description;
}
